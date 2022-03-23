---
title: Code Profiling
tags: [code]
created: 2020-06-28T05:32:33.887Z
modified: 2020-06-28T05:44:55.600Z
---

# Code Profiling

Snippet to make a useful encapsulation in Rails apps.

`config/initializers/rubyprof.rb`:

```
class Prof
  def self.callstack(filename='callstack.html')
    result = nil
    profile = RubyProf.profile do
      result = yield
    end
    report = RubyProf::CallStackPrinter.new(profile)
    File.open(filename, 'w') do |file|
      report.print(file)
    end
    result
  end
end
```

