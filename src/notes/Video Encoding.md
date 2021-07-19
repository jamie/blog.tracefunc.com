---
title: Video Encoding
created: '2020-06-28T04:40:13.716Z'
modified: '2021-07-12T17:20:23.792Z'
---

# Video Encoding

## Bitrates

Amazon H.264 currently (2020) has the following maximum bitrates while streaming:

|           | 720p | 720p HQ | 1080p | 1080p HQ |
| --------- | ----:| -------:| -----:| --------:|
| bitrate   |  4.5 |       6 |    10 |       15 |
| MB/min    |   34 |      45 |    75 |      112 |
| 30m TV    | 1012 |    1350 |  2250 |     3375 |
| 60m TV    | 2025 |    2700 |  4500 |     6750 |
| 90m Film  | 3037 |    4050 |  6750 |    10125 |
| 140m Film | 4725 |    6300 | 10500 |    15750 |

Keep in mind that most videos will not be a constant bitrate, so actual streamed data will be lower.

## HEVC Notes

[Some recommendations specifically for Anime](https://kokomins.wordpress.com/2019/10/10/anime-encoding-guide-for-x265-and-why-to-never-use-flac/) - TLDR; Handbrake, Main 10 profile, `slow` preset:

- 1 Setting to rule them all:
  crf=19-20, `limit-sao:bframes=8:psy-rd=1:aq-mode=3`
- Flat, slow anime (slice of life, everything is well lit):
  crf=19-20, `bframes=8:psy-rd=1:aq-mode=3:aq-strength=0.8:deblock=1,1`
- Some dark scene, some battle scene (shonen, historical, etc.):
  crf=18-19 (motion + fancy FX), `limit-sao:bframes=8:psy-rd=1.5:psy-rdoq=2:aq-mode=3`
  crf=20 (non-complex, motion only alternative), `bframes=8:psy-rd=1:psy-rdoq=1:aq-mode=3:qcomp=0.8`
- Movie-tier dark scene, complex grain/detail:
  `crf=16-18, no-sao:bframes=8:psy-rd=1.5:psy-rdoq=4:aq-mode=3:ref=6`
- I have infinite storage, a supercomputer, and I want details:
  preset=veryslow, crf=14, `no-sao:no-strong-intra-smoothing:bframes=8:psy-rd=2:psy-rdoq=5:aq-mode=3:deblock=-1,-1:ref=6`

Audio: Avoid FLAC (save the data rate for video quality) and reencode, prefer Opus to AAC. If already in a lossy format, just copy it.
- Opus: 192kbps stereo, 384kbps for 5.1.
- AAC (Apple): `-V 109` stereo, `-V 100` for 5.1.
- Fraunhofer FDK AAC (build your own Handbrake with non-free, [docs](https://handbrake.fr/docs/en/latest/developer/build-windows.html)): `-m 5`


