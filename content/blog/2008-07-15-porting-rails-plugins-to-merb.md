---
title:      Porting Rails Plugins to Merb
created_at: 2008-07-15 00:55:00 -0400
tags:       [rails, merb]

directory:  2008/07/15
filename:   porting-rails-plugins-to-merb
extension:  

layout:     article
filter:
  - markdown
---
We're about to start up a new project at work, and we've decided to go with [Merb][] (yay!) rather than [Rails][]. Before we get started, though, we wanted to make sure that we'd be able to integrate well with the various plugins available for Rails.

[Merb]: http://merbivore.com/
[Rails]: http://rubyonrails.com/

The first two libraries we wanted to use were [ultrasphinx][], an interface to the [Sphinx][] fulltext search engine, and [async-observer][], an abstraction library using the [beanstalkd][] work queue library to delay actions to be processed at a later time, rather than while processing the page.

[ultrasphinx]: http://github.com/fauna/ultrasphinx/
[Sphinx]: http://sphinxsearch.com/
[async-observer]: http://github.com/kr/async-observer/
[beanstalkd]: http://xph.us/software/beanstalkd/

The good news is that both of the projects are available on GitHub, which means easy forks, and easy contributions back to the source if my changes are as good as I think they are.

So, today I'd like to talk about the basic changes you'll need to make to a Rails plugin so that it will play nicely with Merb, and a few of the extra hooks that come into play.  In the near future, I hope to provide a bit of a primer on adapting a plugin that uses ActiveRecord so that it will also work with Datamapper.  Preview tip from that post, if you're calling any methods provided by ActiveRecord, *please* make an adapter class/module to pass those methods through, as it makes ports like these *much* easier.

## Basics

To get your plugin to get picked up properly, Rails requires an `init.rb` file in the plugin root.  The equivalent for Merb is a file named after your plugin, in the `/lib` directory.  Copying `/init.rb` to `/lib/async_observer.rb` worked for that one, Ultrasphinx is somewhat better behaved in that its init.rb just required ultrasphinx, so both Rails and Merb worked for me out of the box.

If you depend on anything in Merb, you'll need to add to the docs that applications should add the plugin dependency inside a `Merb::BootLoader.before_app_loads` block - otherwise nothing in Merb is defined yet.  This is of particular importance if you want to switch behaviour based on whether the Rails or Merb constants are defined.  As Rails handles loading plugins itself, there's no concern for keeping things special for Rails.

If you plan on dealing with the app directory structure or environment, an easy way to do it is:

    if defined?(Rails)
      ROOT = RAILS_ROOT
      ENV = RAILS_ENV
    elsif defined?(Merb)
      ROOT = Merb.root
      ENV = (Merb.env == 'rake' ? 'development' : Merb.env)
    end

The additional rake environment transparently proxies to the development db connection, so if you just want to compare your plugin's interpretation of `ENV` the above will make that cleaner.

## Rake Tasks

Rails automatically loads any files matching `tasks/*.rake` in the plugin dir.

Merb needs to be told explicitly, relative to the lib directory.  The canonical example from the docs is:

    if defined?(Merb::Plugins)
      Merb::Plugins.add_rakefiles "merb_sequel" / "merbtasks"
    end

Unfortunately, it seems that it wants specified a single file with a `.rb` extension, which is incompatible with the Rails Way.  The easiest fix I've found is to add a file called `tasks.rb` under `/lib`, inside which you just manually require the individual rake files:

    load File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'tasks', 'merb_sequel.rake'))

Do note that the `load` is necessary, `require` doesn't pick the file up properly.

Finally, if you have any tasks that depend on environment, the easiest way to get compatability with both frameworks is to add `task :environment => :merb_env` to your `merbtasks.rb` file.

## Generators

I haven't looked into generators in too much depth, but the API between Rails::Generator::Base and Merb::GeneratorBase seem different enough to warrant not reusing the generation script.  If you conditionally define a generator based on the `defined?`ness of those two base classes, you should be able to reuse all your generation templates, and both Rails and Merb look in the same place for generators, so that should be the only adaptation necessary.

## ORM Integration

Check back next time, as I write up my experience writing an ActiveRecord shim for the latest DataMapper.  It's vaguely ugly.  I *highly* recommend if you're working on a plugin now that interacts with models to abstract any access to the database into a module, and include it appropriately.  This goes double if you're using any AR magic ;)


