---
title:  'Jekyll: Custom Liquid Tags'
tags:   [blog]
layout: post
---

The base install of [Jekyll][] at the moment doesn't let you run _any_ arbitrary ruby code. This is so that they can use it for github pages and not need to worry about making a super-secure sandbox just to generate some HTML.

[Jekyll]: http://github.com/mojombo/jekyll

Unfortunately, that means we're out of luck for creating custom liquid filters. The most annoying deficiency for me is tags. The way the default liquid `map` filter works isn't friendly with @site.tags, so to generate my [Tags][] page I had to do some really crazy stuff with `capture`:

[Tags]: /tags/

    <div id="articles">
      <table>
        {{'{'}}% for tag_ in @site.tags %}
          {{'{'}}% capture tag %}{{'{'}}{ tag_ | first }}{{'{'}}% endcapture %}
          <tr><th>{{'{'}}{ tag }}</th>
              <th><a name="{{'{'}}{ tag }}" class="anchor">&nbsp;</th></tr>
          {{'{'}}% for post in @site.posts %}
            {{'{'}}% if post.tags contains tag %}
              <tr><td>{{'{'}}{ post.date | date: '%b %e, %Y' }}</td>
                  <td><a href="{{'{'}}{ post.url }}">{{'{'}}{ post.title }}</a></td></tr>
            {{'{'}}% endif %}
          {{'{'}}% endfor %}
        {{'{'}}% endfor %}
      </table>
    </div>

Fortunately, it wasn't to hard to make a fork, and in [my fork][] I added a super simple code loading option. Now, I can add a quick extension in `_lib/filters.rb` like so:

[my fork]: http://github.com/jamie/jekyll

    module Jekyll
      module Filters
        def keys(input)
          input.keys
        end
    
        def tagged(input, tag)
          input.select{|post| post.tags.include? tag}
        end
      end
    end

Now `tags.html` looks like this:

    <div id="articles">
      <table>
        {{'{'}}% for tag in @site.tags|keys|sort %}
          <tr><th>{{'{'}}{ tag }}</th>
              <th><a name="{{'{'}}{ tag }}" class="anchor">&nbsp;</th></tr>
          {{'{'}}% for post in @site.posts|tagged:tag %}
            <tr><td>{{'{'}}{ post.date | date: '%b %e, %Y' }}</td>
                <td><a href="{{'{'}}{ post.url }}">{{'{'}}{ post.title }}</a></td></tr>
          {{'{'}}% endfor %}
        {{'{'}}% endfor %}
      </table>
    </div>

There's a bit of trickery there that liquid doesn't document very well on lines 3 and 5 - in the second half of the for block you can chain filters on the collection you're iterating over. The short format used is something along the lines of `collection|filter:arg,arg,arg|filter...`

Similarly, I had some ugly code in my regular [archive][] page to group by year and put headings in:

[archive]: /archive/

    {{'{'}}% for post in site.posts %}
      {{'{'}}% unless post.next %}
        <tr><th>{{'{'}}{ post.date | date: '%Y' }}</th><th>&nbsp;</th></tr>
      {{'{'}}% else %}
        {{'{'}}% capture year %}{{'{'}}{ post.date | date: '%Y' }}{{'{'}}% endcapture %}
        {{'{'}}% capture nyear %}{{'{'}}{ post.next.date | date: '%Y' }}{{'{'}}% endcapture %}
        {{'{'}}% if year != nyear %}
          <tr><th>{{'{'}}{ post.date | date: '%Y' }}</th><th>&nbsp;</th></tr>
        {{'{'}}% endif %}
      {{'{'}}% endunless %}

      ...
    {{'{'}}% endfor %}

Now, a few extra liquid filters later, it looks like this:

    {{'{'}}% for post in site.posts %}
      {{'{'}}% if post|last_of_year? %}
        <tr><th>{{'{'}}{ post.date | date: '%Y' }}</th><th>&nbsp;</th></tr>
      {{'{'}}% endif %}
      
      ...
    {{'{'}}% endfor %}

If you want to get easy extensions in your own project, rather than maintaining Yet Another Jekyll Fork, please vote up [my merge request](http://github.com/mojombo/jekyll/issues#issue/100) on github.

--------

As a side note, blogging about liquid is a pain. The least pain I've found so far is to use liquid to output the leading open brace for all tags. Looks like garbage in my text editor, but it gets the job done:

    {{'{'}}{{'{'}}'{'}}{ post.title }}

Blogging about blogging about liquid (as above) I leave as an exercise to the reader.
