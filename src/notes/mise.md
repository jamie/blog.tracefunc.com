---
title: mise
created: '2025-01-02T05:11:49.731Z'
modified: '2025-01-02T05:12:31.972Z'
---

# mise

Direvn has a special `layout ruby` command that sets up rubygems/bundler/paths for ease of use. The equivalent in .mise.toml is along the lines of:

```
[env]
BUNDLE_BIN = './.mise/bin'
GEM_HOME = './.mise/ruby'

_.path = [
  "{{env.GEM_HOME}}/bin",
  "{{env.BUNDLE_BIN}}"
]
```

