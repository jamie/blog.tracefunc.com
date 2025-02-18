---
title: Bundler Reporting
created: '2024-04-03T21:57:22.828Z'
modified: '2024-04-03T22:01:10.890Z'
---

# Bundler Reporting

`bundle outdated` is a naive report of what's older than current (and what the current versions are).

[`next_rails`](https://github.com/fastruby/next_rails) ships with some additional tooling - `bundler_report outdated` will enhance the previous with release dates.

[`libyear`](https://libyear.com/) for Python inspired [`libyear-bundler`](https://github.com/jaredbeck/libyear-bundler) which will sum up the diff between the current version's release date and the latest version's release date, and tell you how many lib-years you are behind latest. It has a few runtime modes, but `libyear-bundler --all` does everything.

