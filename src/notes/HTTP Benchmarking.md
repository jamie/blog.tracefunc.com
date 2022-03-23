---
title: HTTP Benchmarking
tags: [tech]
created: 2020-06-23T18:39:31.358Z
modified: 2020-11-23T18:15:16.334Z
---

# HTTP Benchmarking

- [wrk](https://github.com/wg/wrk) is a "more modern" [ab](https://httpd.apache.org/docs/2.4/programs/ab.html) for hitting individual endpoints

- [hey](https://github.com/rakyll/hey) is a more minimal alternative, I like its response time histograms. The response status code counts to let you confirm auth/request is correct (200) but also let you see at what point your webserver starts rejecting traffic due to load is a super useful feature.

- [Locust](https://locust.io/) can define a more real-world usage pattern in python, with multiple concurrent users

