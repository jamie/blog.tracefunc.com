---
layout: home
pagination:
  enabled: true
  per_page: 6
---

<!-- <% if paginate && num_pages > 1 %>
  <p>Page <%= page_number %> of <%= num_pages %></p>

  <% if prev_page %>
    <p><%= link_to 'Previous page', prev_page %></p>
  <% end %>
<% end %> -->

<div id="articles">
  {% for post in paginator.documents %}
    {% render "post", post: post, excerpt: true %}
    <hr class="my-8" />
  {% endfor %}
</div>

<!-- 
<% if paginate %>
  <% if next_page %>
    <p><%= link_to 'Next page', next_page %></p>
  <% end %>
<% end %> -->
