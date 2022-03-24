---
layout: index
---

<div id="articles">
  {% for post in collections.posts.resources limit: 6 %}
    {% render "post", post: post, excerpt: true %}
    <hr class="my-8" />
  {% endfor %}
</div>
