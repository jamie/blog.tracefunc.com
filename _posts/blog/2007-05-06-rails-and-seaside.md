---
title:      Rails and Seaside?
created_at: 2007-05-06 10:41:00 -0400
tags:       [programming, rails, seaside]

directory:  2007/05/06
filename:   rails-and-seaside
extension:  

layout:     article
filter:
  - markdown
---
I'm coming late to the [controversy][], I know. I was talking with a co-worker about Rails and Seaside the other day, and after describing the Seaside structure and philosophy compared to Rails I got to thinking that there's really not as much overlap as some people think between the two.

Rails, at least since v1.2, has a focus on information. It says, I have a bunch of knowledge I'd like to share with the world. Working with routes makes accessing that information fairly uniform, and also allows for deep linking - a reference to that piece of information that won't change. It recognizes that while it's possible to provide access to this information with simple flat files, if you want to provide dynamic views, or frequently updating data, or even provide for display customizations, Rails has facilities for getting you most of the way there.

Seaside, on the other hand, has more of a focus on the application. It provides for a workflow, and pauses in that workflow every so often to display a web page to the user. It says, I want to let you get something done, here, go to it. It provides a framework that lets you write an application similar to a desktop application, but which uses a web browser for its UI and can provide a centralized storage system for the data it manipulates.

Just looking at these, it's easy to see where one framework shines and the other would require more work to get there.

Anything working with a data-centric view or large-scale multi-user behaviour could run very well in Rails. The Blog example is ubiquitous, but also a forum, or news site, or many other applications involving user feedback and the option to deep-link to pages.

Sites with a more workflow-driven, single-user view would do well by Seaside. For example, I think doing an internet banking front-end in Seaside would be excellent. One user working through steps for a number of actions (think of paying a bill - usually 3-4 page loads in sequence), without the need to reference any specific page in the system. Users log in, and can essentially ignore the URL in the address bar for the duration of their visit.

While both kinds of applications can (and have) been done with the other framework, it seems silly to bolt on extraneous features (like meaningful URLs in Seaside, or managing serious page flow in Rails) when you could switch and play to the strengths of the framework. Given the somewhat orthogonal strengths of Seaside and Rails, I can only see the increased choice they bring as a good thing.

[controversy]: http://www.loudthinking.com/arc/000609.html

