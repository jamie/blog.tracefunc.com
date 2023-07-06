---
title: Web Hosting
created: 2022-03-23T17:52:38.339Z
modified: 2023-05-03T16:51:56.113Z
---

# Web Hosting

Specifically with an eye for Bridgetown static sites and/or small Rails apps.

- [Render](https://render.com/) - Static hosting, but also Node/Python/Go/Rust/Ruby/Elixir apps, Postgres, Redis, cron. Everything but cron has a $0 base tier (but Postgres is only free for 90d). TLS support, CDN for assets. Positioning as a better [Heroku](https://www.heroku.com/) given the latter is more or less on life-support.
- [Fly](https://fly.io/) - Run anything in a Dockerfile, deploys to multiple geo locations for fast reads, manages a distributed Postgres cluster across those deploy locations. Loves Elixir/Phoenix (employs Chris McCord).
- [Netlify](https://www.netlify.com/) - Static hosting, serverless functions, form submissions. Baseline pricing by "member" feels weird though.
- [Vercel](https://vercel.com/) - Static hosting, serverless functions, also with the "per member" pricing.

## Database

- [Neon](https://neon.tech/) does "serverless" Postgresql, free tier handles 3gb data and enough active CPU time to manage it. Has a "branch" concept to let you fork your prod database for a staging/QA environment with copy-on-write semantics so it's a cheap operation to spin up, free tier supports 100 hours CPU time across up to 9 non-primary branches.

