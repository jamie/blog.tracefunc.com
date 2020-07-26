---
tags: [tech]
title: Desktop Backups
created: '2020-06-28T04:51:45.194Z'
modified: '2020-07-01T05:20:59.312Z'
---

# Desktop Backups

I use [Time Machine](https://support.apple.com/en-us/HT201250) for backups on the local network, and [Arq](https://www.arqbackup.com/) for offsite.

For both, I need to exclude a few extra locations that are either transient, or easy to replicate.

- `/Applications`, `~/Applications` - Application binaries
- `/Library` MacOS system settings
- `/System` MacOS operating system
- `/private/var` System cache, swap files
- `~/Downloads` Transient storage
- `~/Library/Application Support/Steam` Games
- `~/Library/Arq` Metadata about backups, will re-download from cloud storage if I need to restore backups from Arq
- `~/Movies` Transient storage when travelling
- `~/VirtualBox VMs` Disk images, should manually back up anything in there
- `~/.asdf` Binaries
- `~/.homebrew`, `/usr/local` Binaries
- `~/code` Programming projects, if it's not in git it doesn't exist (Github counts as offsite backup) - excluding the whole thing means I don't need to deal with `direnv`/`logs`/`node_modules`/`vendor/cache`/whatever else individually, and some of those get out of hand pretty quickly.

### Arq 6

The new Arq 6 has a different backup selector. By default it backs up `/Applications`, `/Users`, and `/Library/Application Support`, and has an extensive exclusion list (including Cache, Downloads, ...).

For my own preferences, `/Library/Application Support` is only a few hundred MB so I kept it in, and added the following excluded items:

- `Applications` (covers both paths)
- `VirtualBox VMs`
- `.direnv`
- `.asdf`
- `Movies`
- `Library/Application Support/Steam`
- `com.docker.docker` (where it keeps its containers)
- `node_modules` for Javascript
- `vendor/cache` and `vendor/gems` for Ruby

