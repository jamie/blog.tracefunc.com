---
title: Rails Engines
created: '2021-01-15T06:37:37.294Z'
modified: '2021-01-15T06:42:04.152Z'
---

# Rails Engines

- Dan Manges writes up [an approach to using engines](https://medium.com/@dan_manges/the-modular-monolith-rails-architecture-fb1023826fc4) where the primary Rails app is empty, and merely requires a number of gems + engines. Initial migration sounded like: main app -> engine (so that other engines can depend on it), then admin, API, and frontend can all become separate engines depending on the main "models" engine. After that, models can potentially be split apart into domain contexts, and similarly service objects and miscellany can be focused by domain.
  Benefits to this are a clear delineation of dependencies, and the ability to run tests for each engine independently (so if A and B depend on C but not each other, a change in B doesn't require tests for A to be run).


