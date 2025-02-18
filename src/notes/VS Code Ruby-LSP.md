---
title: VS Code Ruby-LSP
created: '2024-12-12T18:30:06.290Z'
modified: '2024-12-12T18:41:28.099Z'
---

# VS Code Ruby-LSP

VS Code ruby addon likes to create a .ruby-lsp folder and then fucks around with Bundler config to force things running out of there, which breaks my existing checkouts every so often.

Symptoms:

```
❯ bundle config
...
gemfile
Set via BUNDLE_GEMFILE: "/Users/jamiemacey/code/eft3-m1/.ruby-lsp/Gemfile"


❯ env | grep BUNDLE_GEMFILE
[no output, so no idea where this actually comes from]
```

Remedy:

```
❯ export BUNDLE_GEMFILE=./Gemfile
```

(Or, I've also had success not being locked in on my current shell, and just quitting/restarting it).

