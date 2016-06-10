---
title:  'Snippet: col'
tags:   [ruby, snippet]
---

    #!/usr/bin/env ruby
    col = ARGV.pop.to_i-1
    while line = gets
      puts line.chomp.split(/\s+/)[col]
    end

For when you just want a list of filenames from version control, `hg st | grep '?' | col 2`

And because I can never remember the standard unix tool that does the same thing, and awk is awkward.

