---
title: Virtualization
created: 2021-08-31T22:51:16.469Z
modified: 2021-08-31T22:56:46.282Z
---

# Virtualization

Docker Desktop causing drama on the internet today.

Someone shared [multipass](https://multipass.run) as an alternative that will spin up a virtualized Ubuntu, with similar support for mapping folders. Spinning up a comparable selection of services to docker-compose is handled via [cloud-init](https://cloudinit.readthedocs.io/en/latest/topics/format.html), which is able to lean on Chef or Puppet (or just some shell commands).

