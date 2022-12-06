---
title: Coding Style
tags: [code]
created: 2020-03-24T16:22:24.434Z
modified: 2022-11-24T22:08:16.495Z
---

# Coding Style

My preferred coding styles, for spinning up new projects:

### [[Ruby]]

Use [Standard](https://github.com/testdouble/standard), which is built on top of [[RuboCop]].

See [this post](https://evilmartians.com/chronicles/rubocoping-with-legacy-bring-your-ruby-code-up-to-standard) for a good Standard+Rubocop project config, so you can just use Rubocop tooling in your editor.

See also [this post](https://metaredux.com/posts/2020/07/07/a-safer-rubocop-part-deux.html), safe-auto-correct is now a default!

A full (manual) [configuration set](https://thedevpost.com/blog/rubocop-configuration-files-for-rails/) for rails+rspec, noteworthy for the `Layout/ClassStructure` setting.

### [[Javascript]]

Use [Standard JS](https://standardjs.com/), which is built on top of eslint.

### Git notes:

Create a `.git-blame-ignore-revs` file with one commit hash per line (comments with `#`) to get [Github to ignore those commits] when doing `git blame` and related analysis. Run `git config blame.ignoreRevsFile .git-blame-ignore-revs` to get your local git to do likewise.

Now whenever you do a few automated cleanups (one type per commit yeah?) just add that commit hash to the file, and enjoy the lack of noise in your git history.

