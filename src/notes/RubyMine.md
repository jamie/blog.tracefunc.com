---
title: RubyMine
created: '2023-04-20T01:18:56.614Z'
modified: '2023-08-11T21:50:24.345Z'
---

# RubyMine

## Most Useful File View

Switch to Open Files view, on panel settings enable `Tree Appearance -> Compact Directories`, `Open Files with Single Click`, and `Always Select Opened File`. This gives a project view filtered to your working set of files, and by selecting files when they open it'll ensure the tree stays as expanded as possible. Now hit Preferences and under **Editor Tabs** set `Tab placement` to none, and bump up the `Tab limit` to 100 or so to keep it from closing things early.

## Ruby with ASDF

For whatever reason, by default it only found rubies installed via `rbenv`, and not `asdf`.

It can be manually added via Preferences, **Ruby SDK and Gems**, <kbd>+</kbd>, Interpreter..., and browsing to `~/.adsf/installs/ruby/VERSION/bin/ruby`.

However, our app's somewhat older ruby (2.6.9) and rails (5.2) is still hiccuping on things like rubocop.

## With Docker

My work app is running under Docker, documentation suggests you can configure [Docker as a remote interpreter](https://www.jetbrains.com/help/ruby/using-docker-as-a-remote-interpreter.html) to get code analysis, run tests, and debug.

Jamie Schembri [agrees](https://schembri.me/post/rubymine-with-docker/), with some config notes for port conflicts, Sinatra, etc.

However, under Rubymine 2023.2 if I use the default `ruby` path to autodetect, I get "Unable to detect a full path for the interpreter: ruby", and providing a full path `/home/ruby/.rbenv/shims/ruby` gets a bit farther but errors "No EXECUTABLE DIRECTORY in `gem env` response, see logs for more details" - running `gem env` manually from within the docker image happily says "EXECUTABLE DIRECTORY: /gems/bin" so idk...
