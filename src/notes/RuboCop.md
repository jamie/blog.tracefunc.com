---
title: RuboCop
created: 2022-02-24T22:28:57.406Z
modified: 2022-02-25T18:13:51.899Z
---

# RuboCop

[RuboCop](https://rubocop.org/) is a [[Ruby]] code linter.

A quick-and-dirty starting config, bootstrapping a [[Rails]] app:

```ruby
# Gemfile
group :development do
  gem "rubocop", require: false
  gem "rubocop-rails", require: false
  gem "rubocop-shopify", require: false
  gem "rubocop-rspec", require: false
end
```

```yaml
# .rubocop.yml
inherit_gem:
  rubocop-shopify: rubocop.yml

require:
  - rubocop-rails
  - rubocop-rspec

AllCops:
  TargetRubyVersion: 2.7
  NewCops: enable
  Exclude:
    - 'tmp/**/*'
    - 'vendor/**/*'
```

Note that the [`rubocop-shopify`](https://ruby-style-guide.shopify.dev/) dependency is purely a style choice (and my default preference), sticking with Rubocop's baseline, or or use [AirBNB's plugin](https://github.com/airbnb/ruby/tree/master/rubocop-airbnb), or whatever. [StandardRB](https://github.com/testdouble/standard) is another option that likes to run its own binary, but can run through standard rubocop tooling with [this config](https://github.com/testdouble/standard#usage-via-rubocop).

If you're adding to an existing codebase, `rubocop --auto-gen-config` will scan your code and create a file of known violations to whitelist, which you can then incrementally remove and correct. This will require you update your .rubocop.yml to recognize it:

```yaml
# .rubocop.yml, after inherit_gem and require sections:
inherit_from:
  - .rubocop_todo.yml
```

### Class Structure

There's a Layout/ClassStructure cop that allows you to specify a preferred ordering for certain parts of a class, for consistency. An example ([source](https://thedevpost.com/blog/rubocop-configuration-files-for-rails/)):

```yaml
Layout/ClassStructure:
  ExpectedOrder:
    - module_inclusion
    - constants
    - association
    - public_attribute_macros
    - public_delegate
    - macros
    - initializer
    - public_class_methods
    - public_methods
    - protected_attribute_macros
    - protected_methods
    - private_attribute_macros
    - private_delegate
    - private_methods
```

