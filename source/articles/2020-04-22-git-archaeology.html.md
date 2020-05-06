---
title:      Git Archaeology
tags:       [git]
---

Recently at work we passed a major milestone on our codebase, and I wanted to see if I could run some analysis over time on authorship and see how long some early contributors' work stuck around in the product.

A bit of experimentation and random googling left me with these three scripts.

READMORE

The first is `dig.sh`, which will accept the path to the git repository to analyze (because I'm making a few dozen files, and don't want to dirty the primary repo), a date to process, and optionally a commit to analyze. If a specific commit is not provided, it'll look up the first commit before the provided date.

How this looks in practice is something like `./dig.sh ../my_repo 2011-04-01`. Because we run a monorepo now, and have merged a few external repos together, this sometimes didn't pick up a proper mainline commit, I occasionally had to come back on a manual pass and touch it up: `./dig.sh ../my_repo 2011-04-01 4dbdd82`.

The actual meat of the script is the last 3 lines, which gets a recursive directory listing as of the commit in question, filters to files that match a provided pattern, runs git blame across all of them, and counts the number of entries for each author.

    #!/bin/bash

    # ARGV: repo_path, date, commit

    export DIR=`pwd`
    cd $1

    export DATE=$2

    if [ -n "$3" ]; then
      export COMMIT=$3
    else
      export COMMIT=$(git rev-list -1 --before="$DATE" master)
    fi

    export PATTERN='\t(app|lib)/.*\.(rb|js|erb|haml)$'

    git ls-tree -r $COMMIT | egrep -o "$PATTERN" | while read f; do
      git blame -w -M -C -C --line-porcelain $COMMIT -- $f;
    done | egrep -a '^author ' | sort | uniq -c > $DIR/$DATE.txt

Next up is `dig_all.sh`, which is just a barebones orchestration script. Like the above, you provide a repo path and branch, and it will sequentially run through history. Due to the growth in the repo over time, early years would take under 10 minutes/month to process, but months this year were running over 3 hours. Thus the start/end year arguments, so I could run a few scripts simultaneously - it's impressively not disk-bound on my mac, I did some testing and could run 3 at once without significantly slowing the runtime.

<!-- language: bash -->
    #!/bin/bash

    # ARGV: repo_path, HEAD_branch, start_year, end_year

    for year in $(seq $3 $4); do
      for month in $(seq -w 1 12); do
        export DATE=$year-$month-01
        export COMMIT=$(cd $1 && git rev-list -1 --before="$DATE" $2)
        if [ -n "$COMMIT" ]; then
          echo $DATE $(uptime | cut -d' ' -f 1)
          ./dig.sh $1 $DATE $COMMIT
        fi
      done
    done

Once we've got all the data, I wanted to make a [bar chart race](https://app.flourish.studio/@flourish/bar-chart-race) out of it. `massage.rb` to the rescue, collating the raw data, and then outputting a CSV.

    #!/usr/bin/env ruby

    require 'csv'
    require 'pp'

    data = {}
    Dir['*.txt'].each do |file|
      File.readlines(file).each do |line|
        date, _ = file.split('.')
        count, name = line.strip.split(' author ')

        data[[name, date]] = count
      end
    end

    names = data.keys.map(&:first).uniq.sort
    dates = data.keys.map(&:last).uniq.sort

    out = []
    out << [''] + dates.map{|d| Date.parse(d).strftime("%b %Y") }
    names.each do |name|
      shortname = name.match(/^([^ ]+..)/)[1]
      out << [shortname + '.'] + dates.map{ |d| data[[name, d]] || "" }
    end

    puts out.map(&:to_csv)

Et voila (names anonymized to protect the guilty):

<div class="flourish-embed flourish-bar-chart-race" data-src="visualisation/1993347" data-url="https://flo.uri.sh/visualisation/1993347/embed"><script src="https://public.flourish.studio/resources/embed.js"></script></div>
