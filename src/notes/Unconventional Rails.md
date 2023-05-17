---
title: Unconventional Rails
created: 2022-10-04T23:37:27.729Z
modified: 2022-10-04T23:45:22.793Z
---

# Unconventional Rails

Some interesting ideas that buck the trend of The Rails Way in some fashion.

### Views

[ViewComponent](https://minitest.rubystyle.guide/) encapsulates a view context (avoiding ivar/helper bleed) but still uses a standard template.

[Phlex](https://www.phlex.fun/) ([code](https://github.com/joeldrapper/phlex)) goes a step farther, and bundles in a ruby-based html-builder that's almost perfect (I'd rather he used `to_s` instead of `template` to avoid needing the special-case `template_tag`), but based on some past experience with [Arbre](https://github.com/activeadmin/arbre) I'm not entirely sold on it.

### Controllers

I've lost the link, maybe reddit? Someone was talking about a crazy plan of not doing any standard data loads in GET actions, and instead deferring everything to helpers. So `@post = Post.find(params[:id])` goes in a helper, views never directly interact with instance variables, and you just rely on well-scoped small actions. Might pair well with turbo frames?



