---
tags: [tech]
title: Desktop Backups
created: '2020-06-28T04:51:45.194Z'
modified: '2021-06-08T05:37:07.245Z'
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

### Arq 7

Now has an available default backup option of non-system files, being `/Users` with these exclusions:

```
.DocumentRevisions-V100
.MobileBackups
.MobileBackups.trash
.Spotlight-V100
.TemporaryItems
.Trash
.Trashes
.dbfseventsd
.dropbox
.dropbox.cache
.fseventsd
.hotfiles.btree
.vol
Backups.backupdb
Cache
Caches
Library/Metadata/CoreSpotlight
Downloads
DerivedData
node_modules
Logs
iTunes/iTunes Media/Downloads
iTunes/iTunes Media/Podcasts
iTunes/Album Artwork
iTunes/Previous iTunes Libraries
Library/Application Support/CrashReporter
Library/Application Support/Dropbox
Library/Application Support/Google
Library/Application Support/MobileSync/Backup
Library/Containers/com.apple.mail/Data/Library/Mail Downloads
Library/Containers/com.apple.mail/Data/DataVaults
Library/Developer
Library/Google/GoogleSoftwareUpdate
Library/Metadata/CoreSpotlight
Library/Mobile Documents
Library/Mirrors
Library/PubSub/Database
Library/PubSub/Downloads
Library/PubSub/Feeds
Library/Safari/Favicon Cache
Library/Safari/Icons.db
Library/Safari/Touch Icons Cache
Library/Safari/WebpageIcons.db
Library/Safari/HistoryIndex.sk
MailData/AvailableFeeds
MailData/BackingStoreUpdateJournal
MailData/Envelope Index
MailData/Envelope Index-journal
MailData/Envelope Index-shm
MailData/Envelope Index-wal
```

I have added:

- Skip items excluded by Time Machine rules
- `Applications`
- `VirtualBox VMs`
- `.direnv`
- `.asdf`
- `Movies`
- `Library/Application Support/Steam`
- `com.docker.docker` (where it keeps its containers)
- `vendor/cache` and `vendor/gems` for Ruby

TODO: I can probably prune some more space here (`Library/Group Containers` looks like it might be iCloud related and I can redownload, `Library/Caches/Homebrew` is good to clear out, and `Library/Arq` just seems too self-referential to be worth backing up?)

