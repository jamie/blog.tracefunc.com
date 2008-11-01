---
title:      'Snippet: col'
created_at: 2008-04-20 15:30:00 -0400
tags:       [ruby, snippet]

directory:  2008/04/20
filename:   snippet-col
extension:  

layout:     article
filter:
  - markdown
---
    #!/usr/bin/env ruby
    col = ARGV.pop.to_i-1
    while line = gets
      puts line.chomp.split(/\s+/)[col]
    end

For when you just want a list of filenames from version control, `hg st | grep '?' | col 2`

And because I can never remember the standard unix tool that does the same thing, and awk is awkward.

