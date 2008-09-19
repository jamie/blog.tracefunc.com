---
title:      Fish at Last!
created_at: 2008-04-11 17:14:00 -0400
tags:       [osx]

directory:  2008/04/11
filename:   fish-at-last
extension:  html

layout:     article
filter:
  - markdown
---
Somehow, the last update of [MacPorts][] has let me install [Fish][] cleanly, rather than obtusely blowing up as it has in the past.

I highly recommend trying it out: `port selfupdate` followed by `port install fish` should do the trick.

If you want to use it as your default shell, you'll need to `sudo echo /opt/local/bin/fish >> /etc/shells` so chsh will treat it as an approved shell.

[MacPorts]: http://www.macports.org/
[Fish]: http://fishshell.org/

