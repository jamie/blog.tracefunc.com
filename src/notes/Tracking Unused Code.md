---
title: Tracking Unused Code
tags: [Ruby]
created: 2020-08-06T20:07:59.101Z
modified: 2020-08-06T20:10:55.592Z
---

# Tracking Unused Code

[[Ruby]] tools for tracking unused code:

- [debride](https://github.com/seattlerb/debride) does some static analysis
- [rcov](https://thoughtbot.com/blog/cleaning-up-with-rcov) builds reports of what lines get executed arbitrarily (typically would be run on your test suite)
- [coverband](https://github.com/danmayer/coverband) runs rcov in production to show what code is actually being used by users, rather than just tests.

