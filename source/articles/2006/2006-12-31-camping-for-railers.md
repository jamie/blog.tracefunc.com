---
title:  Camping for Railers
tags:   [camping, programming, rails]
---

Well, I managed to get the weight-tracking app functional (graph and all) in about 220 lines, just tweaking the look now. It's a single-script Camping app using Gruff for graphing, with SQLite for data storage. Not exactly the most efficient app (I'm cheating by using a lot of mostly-null records in the database) but it gets the job done.
There were a few things that got me stuck for a bit that weren't obviously mentioned in the camping docs, so I thought I'd put them down here.

If you're planning on letting Camping handle migrations for you (class Weight::Models::CreateEntries < V 0.1) be sure to require 'camping/db', which is what defines the V method.
The equivalent of Rails' /params/ method for get and post variables is /input/ in Camping. Found that one by accident on a JRuby tutorial, of all things.

Not exactly a camping thing, but if you want a non 4:3 ratio gruff graph, send a string '1000x350' or similar.

That being all that I can think of browsing over the source, I think I'm safe recommending camping for quick prototyping. The best part is that if you want to switch over to a full-fledged rails app, you can just copy/paste the models and migrations (Rails and Camping both use ActiveRecord) and if you want to use markaby for your rails views, you can copy them over as well. A little more work organizing the views and correcting urls and such, but mostly painless. Just don't forget to do the testing ;)

