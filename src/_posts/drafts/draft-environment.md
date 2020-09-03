---
title: Development Environments
tags:  [programming]
---

This is how I work up a coding environment, separate from the host OS.

### [ASDF](https://asdf-vm.com/#/)

ASDF provides builds of specific languages/frameworks/tools, but in a unified fashion. For the most part, it depends on the same backends as language-specific tooling does (no need to reinvent the wheel, ASDF uses on ruby-build just like rbenv and rvm do).

### [Direnv](https://direnv.net/)

Direnv helps manage environment variables locked to a particular folder. While this can also be done with language-specific tooling, direnv has two benefits - first, it's hosted directly in the shell so your shell has access to the configured ENV values, and second, [layouts](https://github.com/direnv/direnv/wiki#project-layouts).

Layouts let you specifiy a one-liner to get a locally-sandboxed environment for that language. `layout ruby` for instance will set `GEM_HOME` and `BUNDLE_BIN`, which will sandbox globally-installed gems into `./.direnv/`, and also get your `PATH` set up to run executables through bundler directly, without needing to run `bundle exec` all the time. I honestly use it 95% for this, and 5% for setting a few ENV variables.

> There's also an [ASDF plugin for direnv](https://github.com/asdf-community/asdf-direnv) that's intended to help speed up invocations of ASDF-hosted binaries, but I haven't looked into it much yet.

### The Result

...
