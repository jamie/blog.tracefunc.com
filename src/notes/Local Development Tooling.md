---
tags: [commandline]
title: Local Development Tooling
created: '2020-05-14T17:09:03.258Z'
modified: '2025-01-08T00:29:41.447Z'
---

# Local Development Tooling

Just a summary of the tools I'm using to manage my local development environment.

### 2020

[yadm](https://yadm.io/), [asdf](https://asdf-vm.com/#/), [direnv](https://direnv.net/).

### 2025

- [[chezmoi]] is a [dotfiles manager](https://www.chezmoi.io/) that helps me keep my overall shell environment in sync across machines. It's a minor improvement over yadm, templates are slightly better for mac/linux and personal/work alternates, and I have a preference for file copies over symlinks - if I just have a one-off config change on one machine, I can still do a config sync without needing to juggle git merges.

- [[mise]] is a [manager for version managers](https://mise.jdx.dev/), as well as a shell environment manager. I primarily work in [[Ruby]], but dabble all over, and it makes a lot of sense to replace rvm/rbenv, nvm, pyenv, etc with a single tool that has a consistent interface - and mise is an improvement over [asdf](https://asdf-vm.com/) in that it's zero-config out of the box and smart enough to not need to manually juggle plugin setup. `mise install` in a [[Rails]] project will just do the right thing, setting up the ruby & node versions the repo is already tagged with. It _also_ handles environment variables, and while I like the simplicity of `layout ruby` coming from [direnv](https://direnv.net/), it's easy enough to work with a [mise preset script](https://github.com/jamie/dotfiles/blob/main/home/dot_config/mise/tasks/preset/executable_ruby) to bootstrap project dirs.

## To investigate

- [devenv](https://devenv.sh/) builds atop Nix to set up 100% reproducible local environments/dependencies.

