---
title: Self-hosted Audiobooks
created: 2023-04-06T04:25:03.241Z
modified: 2023-04-06T06:06:04.261Z
---

# Self-hosted Audiobooks

(Note: Cribbed a bunch of this from [seanap's guide on GitHub](https://github.com/seanap/Plex-Audiobook-Guide))

## Converting MP3s to Chapterized M4Bs

- AudioBookBinder for Mac
	- Website (bluezbox.com) no longer exists that I can see?
	- [Mac App Store](https://apps.apple.com/us/app/audiobook-binder/id413969927?mt=12)
	- Standalone, [Mac Informer](https://macdownload.informer.com/audiobookbinder/)
  - Note: Defaults to write m4b in `~/Documents/Audiobooks`, which is a good staging ground for tagging

## Uniform Tags

- [Mp3tag](https://mp3tag.app/) for Mac
- Add an [Audible Scraper](https://github.com/seanap/Audible.com-Search-by-Album) as a custom Web Source
- Possibly need to manually update `SERIES` and `SERIES-PART`/`MOVEMENT`, `ALBUMSORT` "Series Number - Title", `CONTENTGROUP`/`SUBTITLE` "Series, Book #Number" for custom orderings.
- Files on disk: I actually like the [Audio Bookshelf](https://www.audiobookshelf.org/docs#book-directory-structure) scheme for consistency:
  - `Author/Vol X - Year - Title {Narrator}/Title: Subtitle.m4b` but many of those are optional,
  - `Author/Title/Title - Author.m4b` a typical use case for me, allowing filename search by author (and Plex is still reasonably happy) - Do keep the `Title` folder regardless for compatibility with MP3s (and also multi-file M4Bs with big fantasy epics)

## Plex Setup

- Install [AudNexus Metadata Agent for Plex](https://github.com/djdembeck/Audnexus.bundle)
- Configure metadata agents:
  - `Settings > Agents > Artists > Audiobooks` and put Audnexus above Local Media Assets
  - `Settings > Agents > Albums > Audiobooks` and put Audnexus above Local Media Assets
- Create Audiobook Library (`Music`)
  - Advanced settings:
  - Agent: Audnexus Agents
  - Keep existing genres? (New agent pulls 4-6 meaningful genres)
  - Album Sorting - `By Name` (uses ALBUMSORT)
  - `Uncheck` Prefer Local Media
  - `Check` Store Track Progress
  - `Uncheck` Author Bio
  - Genres - `None`
  - Album Art - `Local Files Only`

## Playback on iPhone

- [Prologue](https://apps.apple.com/us/app/prologue/id1459223267) looks like a great option that talks directly to Plex. Download for offline playback and collection support is a one-time purchase.
- Alternately, manage files outside of Plex and use [BookPlayer](https://apps.apple.com/us/app/bookplayer/id1138219998).

