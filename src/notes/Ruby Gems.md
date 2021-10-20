---
tags: [code]
title: Ruby Gems
created: '2020-06-28T04:50:09.125Z'
modified: '2021-08-10T18:02:52.790Z'
---

# Ruby Gems

Just a general collection of gems I've known and loved (or want to try out).

### Comparisons

- [Coditsu](https://diff.coditsu.io) will produce a diff between versions of a gem. Great if you want to see what's changed, or need to do serious auditing of dependencies - run a bundle update, and then hit this for all the changes in Gemfile.lock
- [RailsDiff](http://railsdiff.org/) will produce a diff between the output of `rails new`, handy for making sure you're picking up new default configs as you roll the update train.


### Code Coverage

- Debride finds uncalled methods
- Rcov measures coverage while running tests
- Coverband measures coverage in production

### Commandline

- [Github has a CLI](https://github.com/cli/cli#installation-and-upgrading)

### Database

- [Bullet](https://github.com/flyerhzm/bullet/tree/5.4.3#bullet) detects N+1 queries

### Debuggers

- [Byebug](https://github.com/deivid-rodriguez/byebug/blob/master/GUIDE.md) is my go-to for tracing, to `step` into function calls, skip to `next` line, and `continue` execution.
- [Pry](http://pry.github.io/) is the other really popular one.
- [Jard](https://rubyjard.org/) looks interesting, provides a multi-window debugger environment, with a GUI stack trace, local variable dumps, threads, etc.
- Ruby is also getting a [native debugger in 3.1](https://dev.to/st0012/a-sneak-peek-of-ruby-s-new-debugger-5caa) with more interesting breakpoints/callbacks that might prove useful for IDE integration.

### Worker Queues

All these queues support ActiveJob in Rails

- [Que](https://github.com/que-rb/que) leans heavily on Postgres-specific features for queue management, keeps it in the DB
- [Resque](https://github.com/resque/resque) is Redis-backed, includes a management site
- [Sidekiq](https://github.com/mperham/sidekiq) also Redis-backed, includes management site, and includes a [Pro](https://sidekiq.org/products/pro.html) paid offering with some additional enterprisey features


