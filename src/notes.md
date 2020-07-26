---
layout: page
title: Notes
---

## Notes

I've started keeping a knowledge base of miscellaneous notes and thoughts,
presented here. Still a work in progress.

{% assign notes = site.pages | where:"categories","notable" %}
{% for note in notes %}
- <a href="{{ note.url }}" class="wikilink">{{ note.title }}</a>
{% endfor %}
