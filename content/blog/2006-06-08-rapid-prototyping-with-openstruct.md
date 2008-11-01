---
title:      Rapid Prototyping with OpenStruct
created_at: 2006-06-08 07:59:00 -0400
tags:       [programming, ruby]

directory:  2006/06/08
filename:   rapid-prototyping-with-openstruct
extension:  

layout:     article
filter:
  - markdown
---
I was doing a bit of data processing the other night. A little copying here, a bit of typing there, formatting into YAML, then loaded into a Ruby script. Loop through the hashes YAML loaded, and try to make some sense out of it.

I'm happy to say that I wound up doing the most comfortable thing for munging the data, and it turned out pretty well: OpenStruct.
For those who don't know about it (require 'ostruct'), OpenStruct is exactly as the name says. It's a struct, in that it just holds data, but it is open for extending after you've created it. One can almost treat it like a Hash, but with method calls instead of indexing. (In fact, this week's [RubyQuiz][] was converting YAML-loaded Hashes to OpenStructs)

What I was doing was looping through the Hashes, and creating OpenStructs on the fly to hold the data. At the same time, I was back-referring to previous OpenStructs and appending data to them. I didn't think much of it until I thought to myself that I needed to do some calculations on the data, and the most logical spot for it was in one of my OpenStruct objects.

I was disappointed for a moment because I knew the methods didn't fit in OpenStruct itself, when I realized that it was just time to refactor a bit - take the OpenStructs that were holding the data, promote them to instances of a concrete class, and fit the logic in there.

A quick class def, a handful of attr_accessors, rename the OpenStruct instantiation to my new class, and I was off again, none worse for the wear. Ahh, duck typing, I couldn't have done it without you.

[RubyQuiz]: http://www.rubyquiz.com/quiz81.html

