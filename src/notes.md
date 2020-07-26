---
layout: page
title: Notes
---

## Notes

I've started keeping a knowledge base of miscellaneous notes and thoughts,
presented here. Still a work in progress.

{% assign notes = site.pages | where:"notable",true %}
{% for note in notes %}
- <a href="{{ note.url }}" class="wikilink">{{ note.title }}</a>
{% endfor %}
