---
title:      RPlug Up and Running
created_at: 2007-02-13 16:32:00 -0400
tags:       [programming, ruby, rails]

directory:  2007/02/13
filename:   rplug-up-and-running
extension:  

layout:     article
filter:
  - markdown
---
Well, it's got the basic functionality it needs, so I'm about to put out a 0.1.0 gem for [RPlug][]. It has a dependency on [SourceControl][], which I think only deserves a 0.0.5 release because it only does the bare minimum to support RPlug at the moment.

Both projects are entirely up in subversion if anyone wants to check them out, but they're not quite ready for public consumption at the moment.

Example usage and output follows.

[RPlug]: http://rubyforge.org/projects/rplug
[SourceControl]: http://rubyforge.org/projects/sourcecontrol
    % rplug install exception_logger http://svn.techno-weenie.net/projects/plugins/exception_logger svn
    Recorded exception_logger, run 'rplug update' to pull the latest revision
    
    % rplug update
    Working in project dir /home/jamie/dev/redvase
    Updating exception_logger...
      upgrading to revision 2733
      updating local repository
      Done.
    Updating mocha...
      Done.
    Updating helper_test...
      Done.
    Updating arts...
      Done.
    Updating liquid...
      Done.
    
    % rplug status
    Working in project dir /home/jamie/dev/redvase
    Managing the following plugins:
      arts, revision 70
      exception_logger, revision 2
      helper_test, revision 85
      liquid, revision 140
      mocha, revision 99
    Not Managing the following plugins:
      test_timer
    
    % rplug update -p exception_logger -r 2563
    Working in project dir /home/jamie/dev/redvase
    Updating exception_logger...
      upgrading to revision 2563
      updating local repository
      Done.

For those new to the blog, I'm currently reinventing a few wheels here - RPlug is a replacement for Piston that stores meta-info in config/plugins.yml rather than the version control system, and which does not tie itself directly to Subversion even when given a compatible system (like SVK). It does this by using SourceControl (itself intended as a replacement for RSCM) to handle the interface to the SCM system.
