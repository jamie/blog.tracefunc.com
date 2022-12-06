---
title: Shell Scripts
created: 2022-10-27T17:56:41.397Z
modified: 2022-10-27T18:02:49.026Z
---

# Shell Scripts

Advice from [sharats](https://sharats.me/posts/shell-script-best-practices/):

Use `.sh` file extension.

Use long options where possible.

```bash
#!/usr/bin/env bash

set -o errexit # Exit script on error
set -o nounset # Error accessing an unset variable
               # use "${VARNAME-}" for explicit optional vars
set -o pipefail # fail pipeline if any piped commands fail

# Enable debug mode via TRACE=1 ./script.sh
if [[ "${TRACE-0}" == "1" ]]; then
  set -o xtrace
fi

# If appropriate, switch to script's path before starting work
# cd "$(dirname "$0")"

main() {
    echo do awesome stuff
}

main "$@"
```


