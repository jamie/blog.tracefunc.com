---
title:  Porting Rails Plugins to DataMapper
tags:   [rails, merb, datamapper]
layout: post
---
As a follow-up to my [previous post][], here's some gotchas to be aware of if you're looking to support both ActiveRecord and DataMapper in a Merb (and/or Rails) plugin.

[previous post]: http://blog.tracefunc.com/2008/07/15/porting-rails-plugins-to-merb
[ActiveRecord]: http://rubyonrails.com/
[DataMapper]: http://datamapper.org/
[Merb]: http://merbivore.com/
[Rails]: http://rubyonrails.com/

## The Strategy

The best way I've found to handle multiple ORM support in your plugin is not to start monkeypatching around to make one ORM handle like another.  I've done it, and can tell you that wrapping one ORM's backend into another is [ugly][].

[ugly]: http://pastie.org/233178

The better way is to localize the points where your plugin interacts with the data model, with an eye to swapping them out.  For the above example, I would be better off taking the method that *used* the reflection method and putting it inside an ActiveRecord-specific module.  Then, create a DataMapper-specific module that defines the same method, but instead relies on the DM backend to get at the association information.  Finally, when the plugin was loaded I could just include one of the modules based on which ORM was loaded into the runtime.

## Basic Translation

Now that we have a plan, we can start translating our extracted functions from AR bits to DM bits.  There's a bunch of fairly straightforward transformations we can make.

It's unfortunate that there isn't more unity between the two, as from a library-developer's perspective it would make this sort of thing much easier, but the DM team is pretty vocal about wanting the best API they can get, and not worrying about being hobbled by how AR does things.  I don't particularly disagree.

<table>
  <tr><td>ActiveRecord</td><td>DataMapper</td></tr>
  <tr><td>.find(:all, ...)   </td><td>.all(...)         </td></tr>
  <tr><td>.find(:first, ...) </td><td>.first(...)       </td></tr>
  <tr><td>.find(id)          </td><td>.get(...)         </td></tr>
  <tr><td>.find_all_by_id(id)</td><td>.all(:id => ids)  </td></tr>
  <tr><td>.table_name        </td><td>.storage_name     </td></tr>
  <tr><td>.primary_key       </td><td>.key.first.name   </td></tr>
  <tr><td>.connection        </td><td>repository.adapter</td></tr>

  <tr><td></td><td></td></tr>
</table>

## Raw SQL

If you're running raw SQL queries, firstly, I'm sorry.  Secondly, you want to run `.query` instead of `.execute`.  Thirdly, if you care about getting the results of the query back, AR returns an array of arrays, DM returns an array of hashlike objects, so you want to map them for their values array.  The hashlike object in question is order-preserving, so you'll get things out in the right order.  If you're concerned, grab one of the result objects and verify that the keys array is in the correct order.

## Hooks

ActiveRecord defines a few hook points, along the lines of `before_create` and `after_save`.  DataMapper uses (a modified version of) the Extlib gem, allowing it to hook pretty much any method.  The syntax is like `before(:create)` and `after(:save)`.  AR's hooks pass in the object to work with, DM's have the object available as `self`.

In before hooks, the AR hook chain stops if your method returns false, in DM you must `throw :halt`.

## Things You Shouldn't Be Doing Anyways

If you're manually setting `@attribute` values in your AR code, you'll need to use `instance_variable_set` for DataMapper.  I recommend writing manual accessor methods to wrap it for abstraction.

If you're wanting some arbitrary data structures back, I recommend using OpenStruct (`require 'ostruct'`) to pass structured data back and forth.  This was especially handy when I wanted some results from DM to look like AR, because I was just doing an adapter (bad me!) and the client code wanted to interact with the AR object.  Just be aware that OpenStruct doesn't quite clear out all its methods, so you might want to define some custom readers anyway.  I had problems with `type` in particular, which is a deprecated alias of `class` - redefining the method to return `@table[:type]` fixed that up nicely.


