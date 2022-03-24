---
layout: page
title: Notes
---

## Notes

I've started keeping a knowledge base of miscellaneous notes and thoughts,
presented here. Still a work in progress.

{% assign notes = collections.pages.resources | where:"notable",true %}
{% for note in notes %}
- <a href="{{ note.relative_url }}.html" class="wikilink">{{ note.title }}</a>
{% endfor %}
