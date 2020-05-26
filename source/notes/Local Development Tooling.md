---
title: Local Development Tooling
created: '2020-05-14T17:09:03.258Z'
modified: '2020-05-14T17:21:53.537Z'
---

# Local Development Tooling

Just a summary of the tools I'm using to manage my local development environment.

- [[yadm]] is a [dotfiles manager](https://yadm.io/) that helps me keep my overall shell environment in sync across machines. I'm using alternates for linux support (and should be using it with hostname for a few things due to my work laptop currently being more managed than I usually deal with), encryption (SSH keys), and bootstraps for fresh setup.

- [[asdf]] is a [manager for version managers](https://asdf-vm.com/#/). I primarily work in [[Ruby]], but dabble all over, and it makes a lot of sense to replace rvm/rbenv, nvm, pyenv, etc with a single tool that has a consistent interface. Specifically, this is good for locking a project to a runtime version, without needing to juggle anything systemwide.

- [[direnv]] is a complement to asdf, but it [manages your shell environment](https://direnv.net/) - I've only just started toying around with it, but even just `layout ruby` to get it to automatically isolate my gems and set up paths so I don't need to `bundle exec` anything anymore is great. It also lets me set up some environment variables to get alternate debug info out of our [[Rails]] app without dirtying up my global shell.

