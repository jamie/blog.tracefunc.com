---
title:      Garnet
created_at: 
tags:       [programming, ruby]

directory:  draft
filename:   garnet
extension:  

layout:     article
filter:
  - markdown
---
Dave Thomas' keynote, introducing ruby lite
rip out the cruft, modularize

- move 90% of stdlib to gems
- remove duplication/redundancy, reduce complexity of core

Also, was talking about cluby, syntax changes for better first-class procs

    my_if {cond} {
      if stuff
    } {
      else stuff
    }

Combine, clean up language while we're at it
remove builtins in favor of methods, even if at a performance loss

    class Object
      def &&(other)
        other
      end
      def ||(other)
        self
      end
    end
    class FalseClass, NilClass
      def &&(other)
        false
      end
      def ||(other)
        other
      end
    end

Also remove a bunch of other keywords, defining methods on Kernel or Object, depending

Forked from Rubinius?  Mix code?
