---
title: RubyMine
created: 2023-04-20T01:18:56.614Z
modified: 2023-04-20T01:58:17.199Z
---

# RubyMine

## File View

Switch to Open Files view, on panel settings enable `Tree Appearance -> Compact Directories`, `Open Files with Single Click`, and `Always Select Opened File`. This gives a project view filtered to your working set of files, and by selecting files when they open it'll ensure the tree stays as expanded as possible. Now hit Preferences and under **Editor Tabs** set `Tab placement` to none, and bump up the `Tab limit` to 100 or so to keep it from closing things early.

## Ruby with ASDF

For whatever reason, by default it only found rubies installed via `rbenv`, and not `asdf`.

It can be manually added via Preferences, **Ruby SDK and Gems**, <kbd>+</kbd>, Interpreter..., and browsing to `~/.adsf/installs/ruby/VERSION/bin/ruby`.

However, our app's somewhat older ruby (2.6.9) and rails (5.2) is still hiccuping on things like rubocop.
