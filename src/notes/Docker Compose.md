---
title: Docker Compose
tags: [tech]
created: 2020-06-28T05:05:16.213Z
modified: 2021-07-22T23:17:13.340Z
---

# Docker Compose

Rebuild cluster with updated images:

```
docker compose pull    # fetches new images
docker compose down    # quits servers, removes from docker
docker compose up -d   # brings cluster back up, uses new images
docker image prune -f  # removes now-unused images
```

---

Docker Desktop on MacOS is super obnoxious. Disk access is slower than on Linux (and I think has to round trip through RAM), it randomly drops network shares (sometimes even local disk mounts). I don't recommend for anything long-running like a home media center. Far better doing so with Linux as a host OS.


