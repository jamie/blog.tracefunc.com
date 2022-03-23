---
title: Rails
tags: [code]
created: 2020-04-08T18:07:55.638Z
modified: 2021-06-21T16:24:35.840Z
---

# Rails

Dual-boot [rails upgrade strategy](https://www.fastruby.io/blog/rails/upgrade/our-rails-upgrade-process.html) that I've seen mentioned a few times.

[Synvert](https://github.com/xinminlabs/synvert) helps automatically convert syntax for some rails updates, and a few other gems.

### Architecture

Some [good notes on code organization](https://www.codewithjason.com/organize-rails-apps/) from Jason Swett, the rails testing guy.

### Admin Interface

ActiveAdmin has a lot of mindshare, but I use it extensively and hate it with a passion. Between the obnoxious DSL, the shitty html-in-ruby that is Arbre, and the amazingly bad performance hit reloading a large admin site from scratch on any code change in development, cannot recommend.

Administrate I've tried in a smaller app, it has a bit of magic API for working off of common templates (so for defining fields for the index/show pages, etc), but easily allows you to generate whatever view you need so you can override it with _simple_ erb.

[Avo](https://avohq.io/) is new option, and is paid for extended features. Runs Hotwire on the backend, but might be worth looking at. Has a useful default design for filters/actions that doesn't take up a lot of space from the main interface screens.

