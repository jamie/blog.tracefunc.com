---
title: Rails Deferred Content
tags: [Rails]
created: 2020-07-24T23:28:40.978Z
modified: 2021-10-19T19:02:54.436Z
---

# Rails Deferred Content

[render_async](https://github.com/renderedtext/render_async) is a pretty straightforward setup that lets you defer rendering of various data blocks until after the initial page load. Sounds very similar to what HEY! is doing, allows you to set up your primary pages as static (thus cache-friendly), and defer per-account personalization until later.

[Turbo Frames](https://turbo.hotwired.dev/handbook/frames) is the aforementioned HEY! solution, now open-source. See also [this writeup](https://boringrails.com/tips/turboframe-lazy-load-skeleton) on a practical application of the library.

