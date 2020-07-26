---
tags: [code]
title: Ruby Gems
created: '2020-06-28T04:50:09.125Z'
modified: '2020-06-28T05:47:00.501Z'
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

### Worker Queues

All these queues support ActiveJob in Rails

- [Que](https://github.com/que-rb/que) leans heavily on Postgres-specific features for queue management, keeps it in the DB
- [Resque](https://github.com/resque/resque) is Redis-backed, includes a management site
- [Sidekiq](https://github.com/mperham/sidekiq) also Redis-backed, includes management site, and includes a [Pro](https://sidekiq.org/products/pro.html) paid offering with some additional enterprisey features


