---
title: Isolating Rails
tags:  [rails, ruby]
---

Rails 3 is now very friendly with regards to dropping Bundler support,
only loading it if it's installed and a Gemfile exists. Since [Isolate]
is so awesome, I thought I'd just drop a quick script in here to convert
an existing Rails app to use Isolate instead of Bundler.

[Isolate]: https://github.com/jbarnette/isolate

    #!/usr/bin/env ruby

    require 'fileutils'

    File.open("Isolate", 'w') do |isolate|
      File.readlines("Gemfile").each do |line|
        next if line =~ /^\w*#/
        next if line =~ /^source/
        next if line =~ /^\w*$/

        line.sub!(/, :require.*(,|$)/, '\1')
        line.sub!(/^([ \t#]*)group/, '\1environment')
        
        if line =~ /:git/
          line = "# Don't use git, build it as a gem\n# " + line
        end

        isolate.puts line
      end
    end

    File.open("config/boot.rb", 'a') do |boot|
      boot.puts
      boot.puts("require 'isolate/now'")
    end

    FileUtils.rm('Gemfile')

This should convert an existing Gemfile to an Isolate file, remove the
Gemfile (so that rails won't try to load it), and update the app to load
Isolate appropriately.

I'm basically only guessing that the group/environment setup is correct,
so if anyone has any corrections to this let me know and I'll update it.

