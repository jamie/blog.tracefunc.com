---
title: Git Bisect
created: '2021-07-19T19:10:59.307Z'
modified: '2021-07-19T19:12:28.740Z'
---

# Git Bisect

Cheat sheet:

- `git bisect start`
- `git bisect good [commit]`
- `git bisect bad [commit]`
- `git bisect skip` in case granular commits result in a build failure
- `git bisect run <cmd>` if you're feeling brave about automating, otherwise consider stepwise `<cmd> && git bisect good || git bisect bad`
- `git bisect reset` when done to go back to the branch from `start`
