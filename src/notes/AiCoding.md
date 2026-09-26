Personal experience with tools/frameworks for using LLMs to write code, in brief.

## Editor Plugins

I've used **Cursor** a bit (2024-5), and **Copilot in VS Code** (2025-6), overall not a fan of the UI but that might be a side effect of limitations of VS Code plugins. They're fine for bouncing single prompts (or a series, in conversation) but I haven't been able to get VS Code to do a serious loop without coming back to ask questions all the time.

## CLI

Started my journey with **Copilot CLI** (on account of work is giving us Copilot), which was still annoying about prompting. I built up a task list for it and tried to guide it to just do things one at a time, but it'd do one or two and then stop for a break.

Following this up, I got approval for **OpenCode** at work, it's immediately been much more reliable at doing things until it runs out of work. I actually haven't been using it all that much on CLI yet, as I actually made this jump so I could switch to a desktop app workflow.

A late (early '26) pick-up for a **Claude Code** subscription at last, and it's been fine as well - at the moment no strong opinions for/against when compared to OpenCode.
## Desktop

Started with **[OpenCode](https://opencode.ai/)** desktop, so much nicer to manage for multi-tasking (both with multiple concurrent prompts and with workspaces using git worktrees) than juggling tabs in my terminal. Setup hooks for new workspaces are great, lets me copy over my local .env and kick open a test database so workspaces can do concurrent test runs, but lack of workspace _cleanup_ scripting is annoying. Also annoying is Anthropic blocking them from using Claude Code subscriptions, but paying MS for Copilot to get access to Claude models seems OK for work stuff.

I've now picked up **[Conductor](https://conductor.build)** which requires either Claude or Codex behind the scenes, and has a more featureful interface - workspace setup + teardown scripts, github integration (can push PRs), run scripts for dev servers, etc. Actual quality of prompting experience is comparable to OpenCode, as it's very similar stuff behind the scenes.

Since we don't have Claude at work, I tried some Conductor alternatives: [Emdash](https://www.emdash.sh/) started an application but didn't give me a window (MacOS, 0.4.45). [Paseo](https://paseo.sh/) didn't have a functional terminal, said it was outdated but was not, and didn't appear to have any workspace lifecycle hooks (MacOS, 0.1.42). [Superset](https://superset.sh/) wound up being a long-term winner, but their v2 rollout has been half-baked - v1 supported teardown scripts but v2 doesn't run them, after I've reported that as a bug twice. [Orca](https://www.onorca.dev/) looks like it might be a good contender though - still just terminal wrappers rather than Conductor's rich integration, but it also bundles a real editor (both editor and terminal are vs-code derived).

## Skills

[Simple English](https://github.com/AminBlg/SimpleEnglish) is both pleasant to read and saves some tokens when writing documentation.