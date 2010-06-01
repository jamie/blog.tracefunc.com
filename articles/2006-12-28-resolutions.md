title:  Resolutions
tags:   [blog]

Well, it's that time of the year again, but I thought I'd put up the New Years Resolutions a bit early, since there's one that applies here.

I'm finding that I have a bunch of coding projects that I want to work on, but not enough time for them. One of my resolutions this year is to spend my Saturday mornings doing some coding instead of sleeping in, and then blog about something from the week after lunch. I don't know how these posts will work, but maybe something useful will come of them. If not, it'll serve as a good reminder of what I've been doing over the course of the year.

As a prelude to this, here's a list of the projects I'm working on at the moment (or hoping to work on in the coming year).
## "Competitive" Programming

Sometimes I wind up looking for something outside of the normal, day-to-day stuff I usually do, and there's a few places I go looking at the moment.

I follow the [rubyquiz][] threads on the ruby-talk mailing list, and find that I do about one a month. They're usually just little apps that take an hour or two, that I can focus on clean code.

Second up is [Code Golf][]. I've tackled a few problems with Ruby, and am really curious how some people are managing to squeeze the same functionality I have into half the code size, for some problems. For the uninitiated, golfing started to gain popularity in the Perl community, where people would try to create the smallest source file (measured in bytes) that could satisfy a problem - Code Golf is essentially the same thing, but it supports Ruby, PHP, and Python as well.

The last of the bunch is the [Sphere Online Judge][SPOJ], or SPOJ. The guys that run SPOJ have collected several hundred programming problems from a number of programming competitions (the one I've seen the most is the regional ACM competitions) and have a system set up to accept submissions in over two dozen languages and run them against a validator to check that it's been done correctly. Some of the problems have size restrictions (mostly to prevent hard-coding solutions) but the biggest problem I've come up against doing things in Ruby is execution time. I've got a few problems that I have a working solution for, but I still need to speed it up by about 10x to get under the time limit on their server. That said, I've found those ones to be quite rewarding to work on, as I've managed to get one in particular sped up by over 100x from the initial naive solution just by profiling the code and tweaking the algorithm. Sometimes though, Ruby just is too slow, and I just leave the solution on my hard drive.

[rubyquiz]: http://www.rubyquiz.com
[Code Golf]: http://codegolf.com/
[SPOJ]: http://spoj.pl/

## Fluxx (AI)

I was gifted [Fluxx][] for Christmas, and it's an absurdly fun card game that's quite easy to play. It should be fairly trivial to develop a framework for playing the game, and plug in some AI players that just select cards at random from their hand to play - eventually one of them will win, I'm sure. Once that's done, I want to toy around with creating a (or many) custom AI to beat the snot out of the random players, and then improve on it - mostly just for kicks.

[Fluxx]: http://www.wunderland.com/LooneyLabs/Fluxx/

## RCov-c1

I started work a while back on a modification to [RCov][], a fast ruby code-coverage tool. RCov itself is line coverage tool. Much more useful than line coverage is branch coverage, which Mauricio refers to as C1 on the RCov page. I came up with the idea that it shouldn't be too hard to come up with a modification of [Ruby2Ruby][] that takes the branches in the code, and unwraps all the conditionals. So instead of this:

    if (x and y)
      foo
    else
      bar
    end

I wanted it to output something like this:

    if x
      if y
        foo
      else
        bar
      end
    else
      bar
    end

If a line coverage tool were to be run on the output of this translation, it should be able to approximate a branch coverage tool fairly well. Alas, while I have a Ruby2Ruby subclass that performs this translation correctly for significantly convoluted nested conditionals (finally), something on my laptop no longer plays nice with RubyInline, so I can't get it to run. If I get enough desire (or enough people start bugging me) I might try reinstalling Ubuntu to see if that helps (it started to break about the time I upgraded from Dapper to Edgy), or else I might try upgrading to 1.8.5 and see if that's the problem.

[RCov]: http://eigenclass.org/hiki.rb?rcov
[Ruby2Ruby]: http://seattlerb.rubyforge.org/ruby2ruby/

## rPlug

My day job is writing Rails, and I toy around with it in my off-time as well. I need more than the minimal support script/plugin gives me for maintaining my plugins, and while I think piston is great, the fact that it's SVN only makes it a no-go for me. We have an svn repo that we work from at work, and I carry it around through an svk mirror on my laptop. I've started a potential replacement for piston that stores its meta-information in config/plugins.yml instead of svn properties. It currently can pull plugins from an SVN repository and handle the upgrade path assuming the rails app is in an SVK repository (ie, it does enough to work for me). I'm aiming to broaden that, though, which is why I need...

## SourceControl

I'm a big fan of Mercurial, and the whole distributed-version-control scene (so darcs and monotone too), and I'm disappointed that so many utilities coming out for ruby/rails development are so svn-focused. I mean, we've got [RSCM][], right? So why was it news a few months back that Capistrano gained support for Mercurial because someone agreed to maintain that bit of code? Why aren't they using RSCM?

For me, it's because RSCM refused to run on my linux box (no joke, the gem I pulled down had a conditional that white-listed platforms, and 'linux' was not one of them), and from what I have been able to glean from it it's a tool that still focuses on SCM tools the wrong way. To RSCM, the baseline is centralized version control (svn), and any distributed version control tools need to conform to that mindset. I want to see how things look going the other way - svn is like hg but without the ability to push/pull, not the other way around.

I'll be investigating the RSCM api to see if I can keep it mostly compatable (or add an extra lib to require that can add the correct api points) but I can't quite say I've written any code for this yet.

[RSCM]: http://rscm.rubyforge.org/

## RubyTests

I'm wanting to contribute to the [RubyTests][] project, and actually have some un-committed code out at the moment, but haven't managed to find the time to spend on this lately. I do think that having a unified test suite is a step in the right direction, especially since we're starting to see a proliferation of alternative implementations, and want to find time to work on this.

[RubyTests]: http://rubyforge.org/projects/rubytests/

## Shimmer

[Shimmer][] is a rails-based web photo album app that I wanted to make some tweaks to and use to host some of my photos for family to browse and download. Just laziness that I haven't gotten around to this lately.

[Shimmer]: http://rubyforge.org/projects/shimmer/

## Weight

One of my other New Years' resolutions is to lose some weight - I'm aiming for 2 lbs a month. But, because I'm a geek I want to log my progress on the computer. I did an exercise routine that I managed in Excel for about 9 months, but wasn't losing any weight from it so I kinda just stopped as life got busy in August this year. Also, excel was boring to look at. I want to hack together a Camping app that will log my daily weights (and possibly incorporate the exercise tracking as well - see the [Hacker's Diet][] on that) and provide a pretty graph to follow my progress with. Heck, I might even go for broke and not test it :P

[Hacker's Diet]: http://www.fourmilab.ch/hackdiet/www/chapter1_2_5.html#SECTION0250000000000000000

## Devdot

Last up is my uber-project. The one I've been wanting to spend a lot of time on for at least the last year, but never got around to it. I'm sure anyone who could possibly read this post knows [Trac][]. Ah, Trac, you least-bad of a bunch of bad apps. Rails has a me-too project in [Collaboa][] which, now that I look, seems to have picked up steam again as of the beginning of November. Sadly, it looks like just another Trac clone.

I want something different. I want something that can act more as a project front-end than a repository tack-on. I want automation. Magic, even. I'd like devdot to be smarter than the average tool. I want it to build a new source tarball when it sees a commit. I want it to pick up releases from tags in the repository. Make tarballs for them. Hell, even make gems and send them over to rubyforge. I want it to do rdoc generation and hosting, automatically. Pipe through test runs and coverage reports. And heck, while I'm at it I might as well add ticket and milestone management, and blow past Trac's features in one swift blow. I even have dreams of a message-board that auto-fronts to a mailing list, or RSS feed - whatever floats your boat.

And from the very beginning, I want it to not be for "Subversion projects". I want it to be multi-project from the get-go. I want to give it to [why][] and find it a better replacement for his multitude of trac instances. Same for [Ryan Davis'][] stuff.

But, you know, all in good time. It'll get there when it gets there. In the meanwhile, I'm in it for the fun :P

[Trac]: http://trac.edgewall.org/
[Collaboa]: http://collaboa.org/
[why]: https://code.whytheluckystiff.net/
[Ryan Davis']: http://www.zenspider.com/ZSS/Products/index.html

## And So, It Begins

So having enumerated everything (wow, 9 projects - no wonder none of them get any time) I'll be back on the 6th (if anyone's listening) hopefully doing something useful.
