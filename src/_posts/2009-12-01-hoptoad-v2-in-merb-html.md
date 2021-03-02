---
title:  Hoptoad v2 in Merb
tags:   [hoptoad, merb]
---

[Hoptoad](http://hoptoadapp.com) has been bugging us for a week or two now to upgrade to v2 of its API, so we did that this week for our project at work. Except we're running Merb, not Rails.

Previously, we've been using Atmos' [merb_hoptoad plugin](http://github.com/atmos/merb_hoptoad_notifier), but it looks like it's been abandoned now in favor of a rack handler, and we needed to hack it a bit to support running multiple sites (with different API keys) off our single codebase. I'm always happy throwing code away, though, so I thought I'd try using the official [Hoptoad Notifier plugin](http://github.com/thoughtbot/hoptoad_notifier) and see how hard it is to get working. It wasn't.

First, you probably want to make a gem of the plugin. [I forked it](http://github.com/thoughtbot/hoptoad_notifier) a few days back, and just added a jeweller task to create the gem locally. Install in the local gems directory (or system-wide in production if you want to do it the hard way) and add it as a dependency.

Then, to actually use it, just add the following in the right places:

```ruby
# init.rb, in Merb::Bootloader.after_app_loads

HoptoadNotifier.configure do |config|
  config.api_key = '...'
  config.environment_name = Merb.env
  config.project_root = Merb.root
  # See http://github.com/thoughtbot/hoptoad_notifier/ README.rdoc
  # for other config settings. You probably want to think about
  # params_filters and maybe ignore.
end

# application.rb, if you want available manually.
# If you just want it for completely unexpected errors you can stick it in
# exceptions.rb instead

def notify_hoptoad(error=nil)
  error ||= request.exceptions.first

  data = {
    :controller       => params[:controller],
    :action           => params[:action],
    :url              => "#{request.protocol}://#{request.host}#{request.uri}",
    # Looks like hoptoad is filtering these itself, we don't need to worry about it
    # other than configuring what needs to be filtered
    :parameters       => params.to_hash,
    :session_data     => session.to_hash,
    :cgi_data         => request.env.to_hash,
    :environment_vars => ENV.to_hash.merge(:RAILS_ENV => Merb.env)
  }

  HoptoadNotifier.notify(error, data)
end

# exceptions.rb, override default error handlers to submit to hoptoad

def internal_server_error
  notify_hoptoad
  render
end

def standard_error
  notify_hoptoad
  render
end    

# other spots you handle exceptions inline, just pass in the exception

begin
  ...
rescue => e
  notify_hoptoad(e)
end
```

It's not exactly as magical as the Rails plugin's auto-including, but it looks like it's getting the job done for us.
