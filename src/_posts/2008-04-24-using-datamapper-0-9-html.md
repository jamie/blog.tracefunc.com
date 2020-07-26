---
title:  Using Datamapper 0.9
tags:   [datamapper, merb]
---

So, DataMapper 0.3 was behaving weirdly for me, and I thought I'd try upgrading to 0.9 to see how things are there.  Overall I'm quite liking it, but there's a few catches:

* It's incompatible with Vlad for deployment, haven't looked into it but something in DM is making the 'repository' value unsettable, which Vlad uses to determine the checkout path.

* Legacy connections beware, there doesn't seem to be a current alternative for set_table_name at the moment.

* :memory: is no longer a good name for your test database when using sqlite.  Use a fully-qualified connection string like sqlite://:memory: instead.

* DataMapper::Persistence has been renamed DataMapper::Resource.  Include it in models.

* Validations are an add-on now, include DataMapper::Validate in your model (or even re-open DM:Resource and include it there).

* Properties now take a class instead of a symbol (you can guess at all the main ones), and require the id to be specified like so: `property :id,   Fixnum, :serial => true`

* Associations are renamed, has_one is now one_to_one, has_many is one_to_many or many_to_many, etc.  Haven't delved in deep yet though, so I'm not sure how to define who gets the foreign key.

* New migration code is just now getting in to dm-core, and auto_migrate! is a thing of the past.  Sucks for those of us using sqlite in-memory test databases that need a fresh migration every time.

My installation Rakefile follows, just stuff it in an empty directory and it'll do everything from there. Much thanks to [Atmos](http://atmos.org/) for a good starting point and some setup help.

~~~ruby
desc "Fetch and Install DM and Merb"
task :install_all do 
  config = CONFIG['dm']
  fetch config[:user], config[:repos]
  install config[:install]
  config = CONFIG['merb']
  fetch config[:user], config[:repos]
  install config[:install]
end

desc "Uninstall DM and Merb"
task :uninstall_all do
  uninstall CONFIG['dm'][:gems]  
  uninstall CONFIG['merb'][:gems]  
end

desc "Download latest sources for :project from git"
task :fetch, :project do |task, args|
  config = CONFIG[args[:project]]
  fetch config[:user], config[:repos]
end

desc "Install :project from git"
task :install, :project do |task, args|
  config = CONFIG[args[:project]]
  install config[:install]
end

desc "Uninstall :project"
task :uninstall, :project do |task, args|
  config = CONFIG[args[:project]]
  uninstall config[:gems]
end

def fetch(user, repos)
  base = File.expand_path(".")
  Dir.chdir base do
    repos.each do |repo|
      repo_dir = "#{base}/#{repo}"
      unless File.directory?(repo_dir)
        %x{git clone git://github.com/#{user}/#{repo}.git }
      end
      Dir.chdir(repo_dir) { %x{git pull} }
    end
  end
end

def install(modules)
  base = File.expand_path(".")
  modules.each do |lib|
    Dir.chdir("#{base}/#{lib}") do
      cmd = "sudo rake install 2>/dev/null |" +
            " grep -v '^\(in' |" +
            " grep -v '^[0-9] gem' |" +
            " grep -v '^[IUc\. ]'"
      puts %x{#{cmd}}
    end
  end
end

def uninstall(gems)
  gems.each do |name|
    puts %x{yes | sudo gem uninstall #{name} -aI}
  end
end

CONFIG = {
  'dm' => {
    :user => 'sam',
    :repos => %w(
      do
      dm-core
      dm-more),
    :install => %w(
      do/data_objects
      do/do_sqlite3
      do/do_mysql
      do/do_postgres
      dm-core
      dm-more/merb_datamapper
      dm-more/dm-migrations
      dm-more/dm-serializer
      dm-more/dm-validations
    ),
    :gems => %w(
      data_objects
      do_sqlite3
      do_mysql
      do_postgres
      dm-core
      merb_datamapper
      dm-migrations
      dm-serializer
      dm-validations
    )
  },
  'merb' => {
    :user => 'wycats',
    :repos => %w(
      merb-core
      merb-more
      merb-plugins
      merb-plugins/merb_param_protection),
    :install => %w(
      merb-core
      merb-more
      merb-plugins
    ),
    :gems => %w(
      merb
      merb-action-args
      merb-assets
      merb-builder
      merb-cache
      merb-core
      merb-gen
      merb-haml
      merb-mailer
      merb-more
      merb-parts
      merb_activerecord
      merb_datamapper
      merb_helpers
      merb_param_protection
      merb_rspec
      merb_sequel
      merb_stories
      merb_test_unit
    )
  }
}
~~~
