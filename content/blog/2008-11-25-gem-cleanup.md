---
title:      Gem Cleanup
created_at: 
tags:       [ruby osx]

directory:  2008/11/25
filename:   gem-cleanup
extension:  

layout:     article
filter:
  - markdown
---
The latest version of rubygems seems to be more gung-ho about trying to clean up old versions of gems.  This is fine, except that OSX seems to be *very* protective of its bundled gem directory, refusing to uninstall gems located there even though I'm running the gem command via sudo.

As a result, while gem list tells me that I've got activerecord v 2.2.2 and 1.15.6 installed, gem cleanup fails miserably:

    jamie@juliet ~> sudo gem cleanup
    Cleaning up installed gems...
    Attempting to uninstall activerecord-1.15.6
    ERROR:  While executing gem ... (Gem::InstallError)
        Unknown gem activerecord = 1.15.6

I appreciate Leopard not wanting to break the bundled versions of gems, but having a functioning `gem cleanup` is helpful to me.  Turns out it's pretty easy to just prevent rubygems from checking the Ruby.framework gem path, just create (or edit) ~/.gemrc and include the following:

    gempath:
      - /Library/Ruby/Gems/1.8
      - /Users/jamie/.gem/ruby/1.8

Of course, you'll need to use your own username on the last line there, and you might want to double-check the existing GEM PATH values from `gem env` output so you don't accidentally clobber anything else.  Also, if you've got a previously-generated .gemrc, the gempath key needs to be a string, not a symbol, or else it won't get picked up.  Whee.