---
title: Ruby Typing
created: 2020-10-27T22:37:49.245Z
modified: 2020-10-27T22:44:11.676Z
---

# Ruby Typing

- [Sorbet](https://sorbet.org/) came out of Stripe, using in-line type annotations.
- [RBS](https://github.com/ruby/rbs) is an alternative, requires separate files for defining type signatures (not necessarily in files adjacent to classes, you can put all your types in `sig/` if you like).
- [Steep](https://github.com/soutaro/steep) is a gradual type checker that leans on RBS signatures. Autogenerate `untyped` signatures for most of your classes, and then you can go through them and add actual types. "Easiest way to use RBS" according to Remote Ruby.
