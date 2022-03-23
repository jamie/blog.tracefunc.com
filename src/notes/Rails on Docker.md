---
title: Rails on Docker
created: 2020-08-26T20:50:25.972Z
modified: 2021-05-27T22:24:12.888Z
---

# Rails on Docker

[via](https://ledermann.dev/blog/2018/04/19/dockerize-rails-the-lean-way/)

- Start with Alpine
- Multi-stage build
- Trim build cruft (bundler cache, node_modules, etc)

---

See also, [Jason](https://www.codewithjason.com/dockerize-rails-apps-database/) describing the basics of docker for server dependencies (database, redis, elasticsearch being good opportunities), while still running rails system-native.

