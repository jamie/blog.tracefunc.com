---
title: Rails on Docker
created: '2020-08-26T20:50:25.972Z'
modified: '2020-08-26T20:52:37.903Z'
---

# Rails on Docker

[via](https://ledermann.dev/blog/2018/04/19/dockerize-rails-the-lean-way/)

- Start with Alpine
- Multi-stage build
- Trim build cruft (bundler cache, node_modules, etc)
