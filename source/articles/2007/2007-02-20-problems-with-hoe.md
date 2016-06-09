---
title:  Problems with Hoe
tags:   [programming, ruby]
---

[RPlug][] and [SourceControl][] now officially have Gems out. SourceControl is probably useless for anybody at the moment, but if you are working on a rails repository under SVK and want to manage SVN-backed plugins, RPlug should handle it just fine. Just gem install rplug -y. More compatability to come in the future.

[Updates below]

I've been having problems getting SourceControl deployed, turns out (unsurprisingly) to be user error - I'm new to this whole rubyforge/gem scene.

So, for the record, prior to releasing a gem using Hoe, one needs to get rubyforge configured. For me, this wound up being:

    $ rubyforge setup
    $ rubyforge config rplug
    $ rubyforge config sourcecontrol

After all that, SourceControl is deploying just fine.

I'm presuming that the initial problem was that the gem (and internal file structure) is source_control, but due to limitations on rubyforge the project name is sourcecontrol - somewhere along the way that confusion stopped it from working.

Today, I went mucking around with the packages for it, removed the old one named 'sourcecontrol' and added 'source_control' - removing ~/.rubyforge/auto-config.yml and re-running the rubyforge setup/config picked up the new package id, and everything seems to run just fine now.

[RPlug]: http://rubyforge.org/projects/rplug
[SourceControl]: http://rubyforge.org/projects/sourcecontrol

