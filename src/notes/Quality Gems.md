---
title: Quality Gems
tags: [Rails, Ruby]
created: 2020-08-10T19:08:45.776Z
modified: 2023-01-17T17:13:35.869Z
---

# Quality Gems

TODO: Make a blog post out of this.

A shout-out to some gems/tools that have a well-deserved place in my [[Rails]] toolbox.

-	Pagy (ActiveRecord pagination, focused on performance)
-	Pry (debugger)
-	Rbspy (sampling profiler) [Rust]
-	rack-mini-profiler, flamegraph, stackprof, memory_profiler (performance analysis tooling) - (reference [custom instrumentation](https://samsaffron.com/archive/2013/03/19/flame-graphs-in-ruby-miniprofiler))
-	rubocop / rufo
-	Hamlit
- Fivemat (rspec/cucumber formatter, progress but one line per file)
-	Cells
-	d3js (chart-buildling library) [JS]
-	sidekiq
-	Bullet (detects N+1 queries) - Compare to newcomer [prosopite](https://github.com/charkost/prosopite)
-	Insomnia (HTTP api tool)
- HTTP.rb (compare Typhoeus, others as a blog post?)

And some TODOs that I want to try out.

- [api_struct](https://github.com/rubygarage/api_struct) for writing API clients, as a step up from my usual bit of raw httprb and JSON->hash data bags on the response.

## Evil Martians

Posted an article about their [Gemfile of dreams](https://evilmartians.com/chronicles/gemfile-of-dreams-libraries-we-use-to-build-rails-apps) with a summary of the things they use frequently and why.

