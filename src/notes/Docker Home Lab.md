---
title: Docker Home Lab
created: 2022-08-20T03:08:36.114Z
modified: 2022-08-25T18:16:39.382Z
---

# Docker Home Lab

Using Portainer

Stacks by category, with services:

- Portainer
  - Portainer
- HomeLab
  - pihole or adguard home
	- tailscale (although, possibly this wants to be installed on the host)
	- traefik (DNS -> service ingress, so I don't need to worry about ports)
	- organizr (common frontend hosting multiple apps, maybe don't need traefik with it?)
	- grafana (monitoring) (plus data sources: prometheus? more?)
	- watchtower (keeps containers updated, need to pointedly exclude foundryvtt and generally be aware of what should/shouldn't be safe to eager-upgrade)
- foundryvtt
  - foundryvtt (local D&D server)
- media
  - plex-server (hosts video, music)
	- calibre-web (hosts ebooks)
	- kavita (hosts comics)
	- komga (hosts comics)
	- rtorrent-rutorrent (I dislike the web interface, maybe switch out?)
	- lazylibrarian
	- radarr
	- sonarr
	- jackett


