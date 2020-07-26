---
layout: index
---

<div id="articles">
  {% for post in site.posts limit: 6 %}
    {% render "post", post: post, excerpt: true %}
    <hr class="my-8" />
  {% endfor %}
</div>
