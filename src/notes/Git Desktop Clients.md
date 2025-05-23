---
title: Git Desktop Clients
created: 2023-03-16T05:29:33.573Z
modified: 2023-03-16T06:15:08.954Z
---

# Git Desktop Clients

(for MacOS)

All the below support history/branch/stash browsing, viewing changes, staging changes per-file or per-line, commits (with amend), and various branch operations (eg. drag-and-drop to merge).

## Github Desktop 

![[Github Desktop.png]]

- Does not stage changes directly in underlying git, just keeps it in-app
- Does not appear to have a tree view option for files
- Branch list does not display incoming/outgoing commit counts to the tracking branches
- No tabbed view, just a quick switcher

## Fork

![[Fork.png]]

- No "pull-request" level github integration that I can see
- Most compact tree view

## Git Tower

![[Git%20Tower.png]]

- Does not separate Unstaged vs Staged files, UI mirrors 2-column `git status` output
- No syntax highlighting in diff view

## Kraken

![[Kraken.png]]

- Defaults to a very wide commit history panel, need to click individual files to switch to diff view
- Tree views collapsed by default, either use path view or get used to Expand All
- Awkward per-line stage/unstage behaviour (staging files or hunks is fine)
- Does not pin the default branch (master) to the top of the branch list


