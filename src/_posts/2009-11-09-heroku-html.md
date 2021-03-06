---
title:  Heroku
tags:   [programming]
---

[Heroku][] kicks ass. Very nifty tech running the show, and a really simple interface for deploying - just push up your git repository.

I run this blog through [webby][], which translates some boring old markdown into html so that I can serve it as static files. I like that amount of snappiness.  Heroku wants to run something ruby - rails, merb, or barebones rack.

[Heroku]: http://heroku.com
[webby]: http://webby.rubyforge.org

Turns out, setting up rack to pass static files through is pretty easy, and since I think it just uses send_file behind the scenes, it should be all set up for Heroku to cache it in their Varnish layer, if I ever happen to get a traffic spike.

All you need is a config.ru file like so, and then be sure to include the generated output dir in your git repository:

```ruby
# I don't have file extensions on entry permalinks
Rack::Mime::MIME_TYPES.merge!("" => "text/html")

class DefaultIndexFile
  def initialize(app, &block)
    @app = app
    yield self if block_given?
  end

  def call(env)
    env['PATH_INFO'] << 'index.html' if env['PATH_INFO'] =~ /\/$/
    @app.call(env)
  end
end

use DefaultIndexFile

run Rack::File.new('output')
```
