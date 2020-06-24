---
title: What Comes After MVC
created: '2020-06-03T22:05:23.402Z'
modified: '2020-06-03T22:40:41.830Z'
---

# What Comes After MVC

Via a Railsconf talk, [What Comes After MVC](https://www.youtube.com/watch?v=uFpXKLSREQo) by Peter Harkins.

Advice: most of these extractions can be applied partially, but the farther we go the better our code looks.

Goal: Split code based on two axes, mutability & side effects. 

Immutable means: when we call methods on it with the same arguments, we get the same results.

No side effect means: when we call methods, no other objects change.

### Value - immutable, no side effects

- _Mostly_ a constructor + query/converstion methods.
- Also useful to have comparisons (`==`, `<=>`) and typecasts (`to_s`, `to_str`, `to_a`, `inspect`, etc). Delegate if that makes sense. Use [dry-equalizer](https://github.com/dry-rb/dry-equalizer) or similar if that helps.
- Should be able to freeze after initialize without breaking anything. See also [adamantium](https://github.com/dkubb/adamantium) for an improved auto-freeze.

Extract values from ActiveRecord models to make them easier to reason about, and group similar behaviours. Don't have your values call or return ActiveRecord objects - they're implicitly mutable.

Consider overriding getter/setter methods for an attribute to auto-promote primitives (strings, ints, timestamps, etc) to value objects. Rails 5 [attributes API](https://api.rubyonrails.org/classes/ActiveRecord/Attributes/ClassMethods.html) helps here, but is a bit wordy.

Testing:
- no let
- no stub
- no factory
- no mocks
- assert on results


### Entity - mutable, no side effects

- Job is to have an identity, and wrap up values.
- Often has very little code, because it doesn't _do_ much (on account of no side effects).
- Overall similar to an AR model, but without _any_ side effects.

Extracting Entities from ActiveRecord:
- Find identity (probably primary key).
- Extract Values
- Drive out side effects to Adapters & Shells.

Controvertial Opinion: ActiveRecord models shouldn't call their or other models queries (scopes, find, where) or lifecycle methods (create, save, reload) - eg. any methods with side effects.

Testing:
- few lets for Values
- maybe factories
- maybe stub entites, but not Values
- assert on results
- assert on object state


### Adapter - immutable, side effects

(named after Hexagonal pattern)

- Wraps interaction with the external world (includes your own database!)
- Usually a pretty thin wrapper.

Testing:
- few lets for Values
- often stubs
- asserts on mocks for outgoing queries/commands
- asserts on results are probbaly not worth much


### Shell - mutable, side effects

- Sequence of transformations, imperative code. Sometimes can get away with functional composition of individual steps. ([[Elixir]]'s `|>` embodies this concept very succinctly.)
- Rails Controller actions can be compared to a Shell.
- General shape: talk to adapters, coordinate Values and Entities to do work.
- Harder to reason about, try to keep small.

Testing:
- fixtures with real-world data
- might need factories to create enough Entities
- expect on results, state, and mocks
- Integration: one happy path to ensure objects glue together properly, and regression tests as necessary for confidence
- if you have one integrated test, can stub Adapters later


### Other - mutable, side effects

This is typical Rails code.

See also talks:
- Boundaries by Gary Bernhardt
- Magic Tricks of Testing by Sandi Metz
- Integrated Tests are a Scam by JB Rainsberger
- Domain Driven Design by Eric Evans


### Closing Notes

Immutable objects cannot call mutable objects, effect-free code cannot call code with side effects. Thus:

- Values may only depend on other values.
- Entities might collaborate with other entities, and also encapsulate values.
- Adapters may use values, but are unlikely to depend on other adapters.
- Shells (and other, legacy code) can continue to do whatever it wants.

The benefit of extracting Values, Entities, and Adapters out of the regular ball of code is so that we can have smaller pieces of code that are (a) easy to reason about, and (b) easy to test.

Empirical truth: once your tests start using ActiveRecord, they slow down _immensely_.





