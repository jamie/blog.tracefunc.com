---
title: Commandline Tools
created: '2022-04-13T04:53:13.528Z'
modified: '2022-04-13T04:53:47.222Z'
---

# Commandline Tools

via Julia Evans https://jvns.ca/blog/2022/04/12/a-list-of-new-ish--command-line-tools/

replacements for standard tools

    ripgrep, ag, ack (grep)
    exa, lsd (ls)
    mosh (ssh)
    bat (cat)
    delta (a pager for git)
    fd (find)
    drill, dog (dig)
    duf (df)
    dust, ncdu (du)
    pgcli (psql)
    btm, btop, glances, gtop, zenith (top)
    tldr (man, sort of)
    sd (sed)
    difftastic (diff)
    mtr (traceroute)
    plocate (locate)

new inventions

Here are some tools that are not exactly replacements for standard tools:

    z, fasd, autojump, zoxide (tools to make it easier to find files / change directories)
    broot (a file manager)
    direnv (load environment variables depending on the current directory)
    fzf, peco (“fuzzy finder”)
    croc and magic-wormhole (send files from one computer to another)
    hyperfine (benchmarking)
    httpie, curlie, xh (for making HTTP requests)
    entr (run arbitrary commands when files change)
    asdf (version manager for multiple languages)
    tig, lazygit (interactive interfaces for git)
    lazydocker (interactive interface for docker)
    choose (the basics of awk/cut)
    ctop (top for containers)
    fuck (autocorrect command line errors)
    pbcopy/pbpaste (for clipboard <> stdin/stdout) maybe aren’t “new” but were mentioned a lot. You can use xclip to do the same thing on Linux.

JSON/YAML/CSV things:

    jq (a great JSON-wrangling tool)
    jc (convert various tools’ output into JSON)
    yq (like jq, but for YAML). there’s also another yq
    fq (like jq, but for binary)
    fx (interactive json tool)
    jless (json pager)
    xsv (a command line tool for csv files, from burntsushi)
    visidata (“an interactive multitool for tabular data”)

grep things:

    pdfgrep (grep for PDF)
    gron (make JSON greppable)
    ripgrep-all (ripgrep, but also PDF, zip, ebooks, etc)

