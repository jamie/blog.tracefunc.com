---
title: New Rails
created: '2021-05-07T22:03:08.485Z'
modified: '2021-05-07T22:50:36.751Z'
---

# New Rails

## New Features, Rails 5 (and 4!)

### What We're Doing Already

- Spring preloader
- Strong Parameters
- Web console on error screens

### What We Can Do Right Now

- `rails` CLI: `rake` commands still work but are deprecated, we can now just use `rails db:migrate` etc.
- Bundled secrets: We can encrypt secrets per-environment in the repo, reducing the amount of deploy-time orchestration necessary (and keeping production passwords & API keys out of our AWS images)
  - Config/secrets.yml (4.1, don't use)
  - Encrypted Secrets (5.1, don't use)
  - Credentials (5.2, do use)
- Pending Migration Errors: If you have a pending migration in dev, you get an exception screen
- Form helpers: `form_tag` (143) and `form_for` (154) can now both be replaced by `form_with` - they're not going away (quite yet) but form_with has a much more consistent API.
- ActiveRecord Attributes API: basically, built-in support for logic like our `has_money` helper, but for arbitrary or custom data types.

### What We Can Do With Work

#### Frontend

- ActionMailer previews: lets us define some stub data to render cleanly, and then get a preview in-browser (with multiple variants if needed) - _and_ have a full list of all previews readily available.
- Turbolinks: plays some javascript tricks to get faster page loads (skips parsing/loading CSS/JS from scratch every request). Somewhat obsoleted in Rails 6/7 with Hotwire/Turbo (added feature: works with forms), would need us to do some work cleaning up some of our listener lifecycles to not have resource leaks.
- Yarn/Webpack support: especially if we want to start dabbling with some judicious React components, pulling our JS out of the asset pipeline into native javascript tooling will be nice. Like Turbolinks, would need some work massaging our existing frontend code over.

#### Backend

- ActiveJob (still using a shim, but now we're rails5+ we've got some better options available to us. GoodJob on Postgres has a good feel in Vault, but we'll need to manage the migration carefully.
- ActionCable: gives us the ability to easily provide realtime updates to pages - imagine sitting on an invoice screen and then seeing it change status as the customer pays it.
- ActiveStorage: A standard API (pair of models) to code against for file/large blob attachments. Would be useful to move over and replace our own S3 logic, but also to get rid of our legacy filesystem-based attachments (Paperclip) that require us to have a network share.
- System Tests - write capybara directly, use Chrome, get failure screenshots, etc. No cucumber needed.

#### Caching

- Russian Doll Caching: formalize our model hierarchy, set up triggers so object saves lower down propagate timestamps up the tree, and use object ID + timestamp as a cache key. Then we can cache a bunch of things (complex rendering, calculations) with a simple expiration policy.
- Redis Cache Store: Fresh in Rails 5.2, a rails-native adapter for Redis to do the caching.
- Declarative ETags: if we have the above, we can also set up some browser hints to let us avoid entire page loads on our backend for specific resources - think Invoice/Customer details screens.




