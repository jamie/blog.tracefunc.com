---
title:      Points
created_at: 
tags:       [programming, agile]

directory:  draft
filename:   points
extension:  

layout:     article
filter:
  - markdown
---

A mistake I made early on in my Agile experience was to try and figure out how many hours, or "ideal hours" a point was worth when estimating stories.  I think it's a mistake a lot of people make, trying to convince either themselves or their boss/client that they'll be able to meet a schedule with confidence.  Unfortunately, it winds up being a case of putting the cart before the horse.  Defining points in terms of time makes them redundant, you might as well just use time to begin with.  The value in points is when you run the translation to time the other way.

A better way is to treat a point as an abstraction.  It's an estimated measure of difficulty, relative to other stories you're working on now, or in the recent past.  The important thing to keep in mind is that it's just an estimate.  When we complete an iteration and look back at the stories completed, some estimates will have been high, needing less work to complete, others will have been low, the tasks winding up having been more involved than you'd thought.

That's OK.  Over time, the high and the low estimates will average out, and you'll also get better at performing the estimates, so there'll be less variance.

The real value comes when you've completed the first few iterations of a project, and look back at the number of points worth of stories that were completed in each.  When we average those values to produce a velocity metric, we don't care about the absolute value of the number, so much as how it relates to the remaining stories in the backlog.  From the velocity, we can then vaguely point-box future stories into iterations, giving us an estimated date of completion for any particular group of stories.

It's important to remember that this is _also_ an estimate.  It's painful to hear from management that we're "not going to _make_ our velocity" this iteration, when that's exactly what we want to happen sometimes - if something's changed in the workplace (and something's always changing) that has affected our development speed, we want to know about it as soon as possible, and that's one of the benefits of doing the whole Agile process.


