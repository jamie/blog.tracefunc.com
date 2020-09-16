---
tags: [tech]
title: Docker Compose
created: '2020-06-28T05:05:16.213Z'
modified: '2020-09-03T21:38:36.382Z'
---

# Docker Compose

Rebuild cluster with updated images (I've got a finnicky cluster):

```
docker-compose down
docker-compose pull
docker-compose up
^c
docker-compose up -d
docker image prune -f
```

(that last one gets rid of now-unused images)

---

Docker Desktop on MacOS is super obnoxious. Disk access is slower than on Linux (and I think has to round trip through RAM), it randomly drops network shares (sometimes even local disk mounts). I don't recommend for anything long-running like a home media center. Far better doing so with Linux as a host OS.


