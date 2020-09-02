---
title: Rails Upgrade Notes
created: '2020-08-19T23:59:48.985Z'
modified: '2020-08-20T00:00:59.059Z'
---

# Rails Upgrade Notes

Good advice from [Arkency](https://blog.arkency.com/painless-rails-upgrades/):

> Go for tactical DDD patterns for your core domain. Modularize your code, extract [Bounded Contexts](https://blog.arkency.com/tags/bounded-context/). Use Rails where they shine: `ApplicationController`, `ActiveRecord` used for writes and reads without the callback hell and STI. We’ve shown you the alternative approach many times: [commands](https://blog.arkency.com/tags/commands/), [service objects](https://blog.arkency.com/tags/service-objects/), [process managers](https://blog.arkency.com/tags/process-manager/), etc. Believe us, your next upgrade will be just a matter of Rails version bump in your Gemfile.
