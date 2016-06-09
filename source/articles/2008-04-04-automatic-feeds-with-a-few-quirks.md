title:  Automatic Feeds with a few Quirks
tags:   [blog]

So, in the interest of keeping this blog as simple as possible (for me), I'm providing feed information on the front page as [hAtom][] marked-up data.

This is then passed through [Subtlety][] to provide a regular Atom feed, which [Feedburner][] is pointed at.  Then I include a <link> tag in the HTML head, and away we go.

However, I just noticed an odd little quirk (in google reader at least), in that if I edit a post that's still on the front page, even though the timestamps and description shouldn't have changed, the post body changing caused a duplicate entry in my reader.  Go figure.

Hopefully, I can bump the [Holmes][] article off the front page before I add more entries to it.

[hAtom]: http://microformats.org/wiki/hatom
[Subtlety]: http://subtlety.errtheblog.com/
[Feedburner]: http://www.feedburner.com/
[Holmes]: http://blog.tracefunc.com/2008/04/01/holmes-on-software

