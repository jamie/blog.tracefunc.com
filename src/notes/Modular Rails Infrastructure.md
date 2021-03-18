---
title: Modular Rails Infrastructure
created: '2021-01-15T06:37:37.294Z'
modified: '2021-03-18T05:24:34.616Z'
---

# Modular Rails Infrastructure

- Dan Manges writes up [an approach to using engines](https://medium.com/@dan_manges/the-modular-monolith-rails-architecture-fb1023826fc4) where the primary Rails app is empty, and merely requires a number of gems + engines. Initial migration sounded like: main app -> engine (so that other engines can depend on it), then admin, API, and frontend can all become separate engines depending on the main "models" engine. After that, models can potentially be split apart into domain contexts, and similarly service objects and miscellany can be focused by domain.
  Benefits to this are a clear delineation of dependencies, and the ability to run tests for each engine independently (so if A and B depend on C but not each other, a change in B doesn't require tests for A to be run).

- Consider? Bust hard mid-tier dependencies (between groups of models, for examples) by hooking up pub-sub at the controllers level (see [wisper](https://github.com/krisleech/wisper) as an example)

### Github Actions

Github actions can set an output variable by printing to stdout: `::set-output name=variable::value`

If I have a step named `filter-components` that does dependency analysis to determine which gems/engines to build, and I run a loop `puts "::set-output name=#{component}::#{component}}"` then I should be able to set up build steps for each component, like so:

{% raw %}
```
<% components.each do |component| %>
<%= component %>:
  needs: filter-components
  if: ${{ contains(steps.filter-components.outputs.*, '<%= component %>') }}
  steps...
```
{% endraw %}

and I think this will properly flag skippable components as not-run (grey) without failing the build or acting as though they were run and are passing.

#### setup-ruby

Note: the ruby/setup-ruby action [now supports bundler caching natively](https://github.com/ruby/setup-ruby#caching-bundle-install-automatically)

