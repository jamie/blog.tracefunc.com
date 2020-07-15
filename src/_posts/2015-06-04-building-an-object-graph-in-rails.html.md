---
title: Building an Object Graph in Rails
tags: [ruby, rails]
---

I was needing to do some object cleanup in our rails app the other day, and purge some malformed objects, so I put together a quick script using some ActiveRecord reflection to walk the object chain.

READMORE

~~~ruby
# Squelch SQL logs, if you're running from rails console
ActiveRecord::Base.logger.level = 1

# Output formatters. Trailing ':' on both, plus the staggered indent
# of 4n and 4n+2 makes the output valid YAML, if automated analysis
# is called for.
def puts_node(node, indent)
  puts "    "*indent + node.class.name + "#" + node.id.to_s + ":"
end
def puts_assoc(assoc, indent)
  puts "    "*indent + "  " + assoc.to_s + ":"
end

def puts_tree(node, seen=[], indent=0)
  puts_node(node, indent)

  unless seen.include? node
    # seen maintains a list of nodes to avoid mutual recursion
    seen << node
    node.class.reflections.keys.each do |assoc|
      # To see all locations an object is referenced, get rid of the
      # "- seen" here. I only cared about which objects were present
      # anywhere in the tree, so this was fine.
      associated = Array(node.send(assoc)) - seen
      next if associated.empty?

      # Print an entry for the association, then recurse
      puts_assoc(assoc, indent)
      associated.each do |subnode|
        puts_tree(subnode, seen, indent+1)
      end
    end
  end

  # Also outputs a footer listing all seen objects once, take it or leave it
  if indent.zero?
    puts
    seen.each {|node| puts_node(node, indent)}
  end

  nil # return nil to avoid flooding terminal in rails console
end

# Usage: call with the root node for the object graph
puts_tree(User.find(42))
~~~

Worked like a charm, and made it easy to compare my bad object with other good ones. Just be careful of any global objects (a common shared subscription package, for instance, that `has_many :users`) that could lead to traversing your entire database, or logging associations that could overwhelm your output on older or heavily used objects. Subtracting a blacklist from reflection keys on line 18 would do the trick there.
