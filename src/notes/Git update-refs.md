---
title: Git update-refs
created: '2024-07-15T15:50:27.371Z'
modified: '2024-07-15T15:53:11.783Z'
---

# Git update-refs

via https://andrewlock.net/working-with-stacked-branches-in-git-is-easier-with-update-refs/

When working with stacked branches/PRs, juggling them is a pain but you can `--update-refs` on a rebase from the tip of the stack and it'll update the intermediary branches. (Not sure how much of a pain it is to re-push them all, though.)

If your tooling doesn't support it, you can opt in globally via:

```
git config --global --add --bool rebase.updateRefs true
```

or manually editing your `.gitconfig`:

```
[rebase]
    updateRefs = true
```

