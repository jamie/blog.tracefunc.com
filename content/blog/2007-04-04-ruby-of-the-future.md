---
title:      Ruby of the Future
created_at: 2007-04-04 10:32:00 -0400
tags:       [ruby]

directory:  2007/04/04
filename:   ruby-of-the-future
extension:  html

layout:     article
filter:
  - markdown
---
Pat Eyler's April [contest][] asks what changes could improve Ruby without losing the feel of the language. I've got four ideas. Even I would consider them quite radical, and don't think they're likely to occur, but if in the future Matz decided that sweeping changes were in order and that backwards compatability wasn't an issue, they'd be on my wish list.

[contest]: http://on-ruby.blogspot.com/2007/04/april-bloggin-contest.html

First, trim Ruby's core. Go through the whole shooting match and pull out anything that isn't likely to be used by at least 80% of the population, and move it into the standard library. Pay special attention to anything written in pure Ruby. CSV, Generator, PrettyPrint, RSS, RUNIT, Rinda, SOAP, and others could be pushed out of Ruby's core.

Similarly, anything with redundancies probably should be moved out too - Ruby's current core has getopts.rb, GetOptLong, OptionParser, Options, and there's a handful of 3rd party libraries available to parse commandline options. Do these all really need to be in core? (Heck, do they all need to be in StdLib for that matter? getopts.rb has as its only comment that it is deprecated and to use another library instead.)

Cleaning up Ruby's core would allow alternate implementations to focus more specifically on what is needed to get Ruby running, without the distractions of extra bundled libraries. It would also provide a smaller base of knowledge for those new to Ruby to learn before they can claim to "know" the language.

My second wish would be to improve the OO-ness of Ruby. Yes, we're miles ahead of Python and its large number of global functions, but a split from some of the old Perlisms could possibly result in an improvement of maintainability. If a number of the magic global variables were scrapped (or at least replaced with the English module) someone who doesn't muck about with them on a day-to-day basis can at least have a chance of figuring out what's going on. I know that I still need to look up $$, $_, $' and others when I see them, and I've been working in Ruby for about a year and a half now.

If everyone were forced to use English-style accessors, and actually go through the OO interface for information (ie, Regexp.last_match instead of magic globals) it should lead to more self-documenting code.

Third, I'd like to see what could be done to trim down the syntax a little. Do we really need ?A to provide us the same information as "A"[0]? I'm loathe to suggest %w() and friends for trimming as I find them useful fairly often, but that's also something that could be looked at. Having the language specified with a parser generator means that alternative implementations can be almost guaranteed to be matching the spec with little effort. Making the core language simpler, with fewer gotchas, also improves the speed at which it can be learned.

Lastly, I'd like to see a step taken towards standardizing on some kind of Unicode, and updating the core language (strings, regexps, and all) to make it as seamless to use as possible. The Rails guys have got things started with multibyte strings in ActiveSupport, but I think it would need to be baked in to the language to be as comprehensive as possible.

All four of these changes would require a lot of work, and likely result in incompatabilities from current versions of Ruby (excepting possibly the last one). However, I think taking these as a base to work on streamlining the language, it could result in a Ruby that is easier to learn, easier to work with, and easier to duplicate or extend, while still retaining the core features that make it what it is.
## Comments

Best entry so far in my opinion. I agree with all of your points, particularly the first two.

- Peter Cooper, at 19:01, Apr 28 2007

Finally got the comment problem fixed, looks like an older version of Mephisto was doing weird things with the page cache. If anyone happens to notice that comments are back up, you can join in now :)

- Jamie, at 19:13, Apr 30 2007

