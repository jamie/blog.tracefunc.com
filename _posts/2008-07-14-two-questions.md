---
title:  Two Questions
tags:   [ruby]
layout: post
---
**Question #1:** Why is Symbol#to_proc so popular?

    class Array
      alias old_map map
  
      def map(method=nil, *args, &blk)
        return old_each(&blk) if block_given?
        old_map do |e|
          e.send(method, *args)
        end
      end
    end

    ary = %w(hello world)
    puts ary.map(:reverse).join(" ")
    puts ary.map(:*, 2).join(" ")
    puts ary.map(:slice, 1, 3).join(" ")

It should be trivial to do this for the other common enumerable methods, the only places I see Symbol#to_proc used, anyway.

I posit that the answer is question 2.

**Question #2:** Why do I need to do this method hackery in Array instead of Enumerable?  I can understand Array having its own definitions of the standard collection methods for performance reasons, but in a properly OO system, that should be transparent to me.

