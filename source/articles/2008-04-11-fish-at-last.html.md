---
title:  Fish at Last!
tags:   [osx]
---

Somehow, the last update of [MacPorts][] has let me install [Fish][] cleanly, rather than obtusely blowing up as it has in the past.

I highly recommend trying it out: `port selfupdate` followed by `port install fish` should do the trick.

If you want to use it as your default shell, you'll need to `sudo echo /opt/local/bin/fish >> /etc/shells` so chsh will treat it as an approved shell.

[MacPorts]: http://www.macports.org/
[Fish]: http://fishshell.org/

