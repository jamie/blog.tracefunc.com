---
title:  How to crash Ruby
tags:   [programming, ruby]
---

```ruby
class BrokenError < StandardError
  def backtrace
    raise(StandardError.new)
  end
end

begin
  raise BrokenError.new
rescue e
  puts 'rescued'
end
```

Because of the exception in the backtrace generation, processing just dies. If you have an at_exit block, it will still be run, so I suppose I'm not really crashing the ruby interpreter, I suppose, but it comes close.

Found this one out migrating a rails app from 1.1.6 to 1.2. Instead of doing this:

```ruby
render 'controller/action'
```

the deprecation warning suggests the following:

```ruby
render :file => 'controller/action'
```

Unfortunately, this causes the error if you're still trying to run in 1.1.6. A more complete fix is to make sure to add use_full_path to the render call to prevent an older TemplateError from horking, like so:

```ruby
render :file => 'controller/action', :use_full_path => true
```
