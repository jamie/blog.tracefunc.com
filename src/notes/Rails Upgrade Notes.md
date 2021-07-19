---
title: Rails Upgrade Notes
created: '2020-08-19T23:59:48.985Z'
modified: '2021-06-07T17:30:52.372Z'
---

# Rails Upgrade Notes

Good advice from [Arkency](https://blog.arkency.com/painless-rails-upgrades/):

> Go for tactical DDD patterns for your core domain. Modularize your code, extract [Bounded Contexts](https://blog.arkency.com/tags/bounded-context/). Use Rails where they shine: `ApplicationController`, `ActiveRecord` used for writes and reads without the callback hell and STI. We’ve shown you the alternative approach many times: [commands](https://blog.arkency.com/tags/commands/), [service objects](https://blog.arkency.com/tags/service-objects/), [process managers](https://blog.arkency.com/tags/process-manager/), etc. Believe us, your next upgrade will be just a matter of Rails version bump in your Gemfile.

### Via Rubocop

It should be possible to leverage Rubocop to migrate a bunch of mechanical/api changes. For example, upgrading Rails 4 -> 5 on a recent project, this would be a trivial change to automate a rewrite:

```
-  before_filter :ensure_policy_access
+  before_action :ensure_policy_access
```

Especially on larger teams with existing work going along parallel to upgrade work, it's very worthwhile to write some rewrite cops to both ease merging new features into an upgrade branch, and to act as a reminder/safety net after the upgrade hits master to guide other developers.

In fact, the [rubocop-rails](https://docs.rubocop.org/rubocop-rails/cops_rails.html) gem may actually cover 

See [this article](https://kirshatrov.com/2016/12/18/rewrite-code-with-rubocop/) for a starter example, and [this article](https://medium.com/@SamJewell/make-your-rails-5-upgrade-easier-with-rubocop-7f9a700b0112) that stands up an example workflow with what I think are some cops already in core Rubocop.


