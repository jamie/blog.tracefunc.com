---
title:  Fun with Routes
tags:   [programming, rails]
---

Rails' routing framework is a pretty capable beast, but it does sometimes still need a bit of help doing more exotic things.

I ran across an example from someone a few months back (either on the mailing list or in a blog post, I can't find any trace of it now) that was using multiple routes to match the same thing - a GUID that could belong to one of many different models. This was done with an overloaded Regexp subclass that pattern matched the GUID, and then looked it up to see if it existed for that model. I wanted to do something similar to that for a project I'm working on, and since I couldn't find an example to copy off of, I went delving inside routing.rb on my own.

The long and short of it is that the following code seems to be a workable solution for me, while being generic enough (the only real custom line is the last one inside the module def) for anyone to incorporate into their code.

```ruby
module ActionController::Routing
  module ConditionConstants; end

  class CustomCondition < Regexp
    def initialize(name, &match)
      super '^$' # pretend we're a regular empty string regexp
      @name, @match = name, match
    end
    def =~(other); @match.call(other); end
    def inspect;   @name;              end
  end

  def self.custom_condition(name, &block)
    ConditionConstants.const_set(name, CustomCondition.new(name, &block))
  end

  custom_condition('ProjectCondition'){|other| Project.find_by_url(other) }
end
```

The only other thing to do is include ActionController::Routing::ConditionConstants inside the block attached to draw so your connect calls can see the constants being defined - AC::Routing seems to have no problem seeing them, even though they're inside a module of their own.

Anyone interested in the hows and whys, feel free to read on...


The goal then, is to come up with an object that can perform an arbitrary condition for use in routes. My usage is a simple lookup in one of my ActiveRecord models, but really you could do anything you wanted. So let's take a look through the generation of a route.

First off, you create routes using the draw method of ActionController::Routing::Routes, which accepts a block detailing the routes you want to connect. Routes is actually not a class with a class method draw, but rather is an instance of AC::Routing::RouteSet. draw yields the RouteSet to the content block, so let's take a look at it for a moment.

The RouteSet#connect method takes a bunch of arguments, and passes them directly into the constructor of AC::Routing::Route. Route accepts two parameters: a path, and an options hash. The path can be either a string (which is split on '/') or an array. The options hash is populated with either defaults or conditions for the various parts of the path.

While you can explicitly define :defaults and :conditions with their own subhashes, but Route is smart enough to do some thinking for you: if the value for a given key is\_a?(Regexp), it is treated as a condition, otherwise it is considered a default. Therefore, this is the first test that our custom condition must pass. Fortunately, it's trivial to write an is\_a? method on whatever class we end up writing that returns true for Regexp, so it's not a big stumbling block.

Now, I have to admit I snuck a bit ahead of the game here - when Route was doing data massaging on the path, it is creating AC::Routing::Components to store each part of the path. There are actually four different subclasses of components, each created by the base Component class. The one we're interested in is DynamicComponent, which is created when the path looks like a symbol. ControllerComponent matches on the explicit symbol :controller so that it can deal with modules, so we don't need to worry about it.

This comes in later on in RouteSet#draw. After creating the various Routes, it calls methods named write\_generation and write\_recognition. write\_generation sets up rules for turning a params hash into an actual URL. write\_recognition does the other way, which is what we want.

write\_recognition then, assembles the recognition rules for each of its Routes, which through a roundabout way calls the same on each Component. The DynamicComponent we were looking at then calls the class method Routing.test\_condition with its condition. This leads us to our second constraint on our custom class - test\_condition runs the condition through a case statement, putting classes on the whens. The when Regexp condition behaves the same as if Regexp === condition, which only evaluates true when condition is an instance of Regexp or a subclass.

This is significantly more difficult to fake than being able to redefine is\_a?, and I really didn't want to come up with a solution that required hacking into Regexp to get anything done. The next two lines after the when (that's 38 and 39, for those playing at home with Rails 1.1.2) add two other wrinkles in the behaviour.

The first is that if the Regexp instance is not bookended by beginning-of-string and end-of-string matchers, a new instance is created that is wrapped so. However, this isn't as bad as it looks at first. Since we're not actually using the Regexp source for any pattern matching, we can satisfy this criteria by setting the pattern to /^$/, which matches an empty string.

The second is significantly trickier, in that when our matcher is inspected, it needs to output as a string the ruby code used to create it. This is fine for normal regular expressions, as /^$/.inspect does actually print out "/^$/", but if we want our matcher to be highly dynamic, it effectively rules out using blocks or procs directly as we would expect. Additionally, the output of the inspect call is then directly sent an =~ call with the part of the path it is trying to match.

My first thought on this was to use classes, since I could create an instance that would pass the "is a subclass of Regexp" test, output the name of the class, and use a class method to do the actual matching (coming later), but that was looking much too ugly. Then I realized that the reason I was drawn to classes is that it is a constant that knows how to look itself up. If I were to teach a Regexp subclass the name I'm about to assign to it, it will know how to reference itself directly, and storing it in a constant means I should be able to get easy access to it by the time we get that deep into the code.

Thus began my CustomCondition class.

I first set up an empty module named ConditionConstants that I would use to house my constants.

Next up was the class - a subclass of Regexp to pass the is\_a? and === tests, but with an overoaded initialize. This first set up the Regexp base to use the empty string regex listed above to prevent Routing from stepping over the constant. initialize also accepted the name of the constant it is about to be stored in, and a block of code to execute later on.

CustomCondition#inspect did the obvious, and output the name we were to be remembering.

CustomCondition#=~ simply called the stored block with the argument we are trying to match, allowing the creation of the object to completely drive its purpose.

Lastly, since all the work was being done in the ActionController::Routing module, I created a class method that would do the creation and assignment for me so that I was doing less direct repetition.

Once that was all in place, I simply called my helper method with the name of the constant, and a block encapsulating the behaviour. Done and done.


