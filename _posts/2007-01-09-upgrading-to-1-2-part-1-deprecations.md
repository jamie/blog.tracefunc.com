---
title:  'Upgrading to 1.2, Part 1: Deprecations'
tags:   [programming, rails]
layout: post
---
So I've been spending some time lately working on upgrading the existing codebase for some projects at work such that they'll work in Rails 1.2 once it's released. Sadly, the upgrade process is not without its rough edges, and after two days of poking at it (it being a 5800 LOC app with 8800 LOC of tests) I'm still not completely done - the test run does not pass cleanly.

However, I have managed to get rid of most of the niggly deprecation warnings, so the output of the rake run is down to 450k from a high of about 2.2mb. Fun times. The changes required to silence most of the warnings are...


## ActiveRecord

find\_all and find\_first are deprecated. Use find(:all) and find(:first) instead.

If you have a has\_many which is :dependent, make sure you're specifying :destroy or :delete\_all, rather than true. If you've got true you probably want to replace it with :destroy. Slower, but safer.

## Routes

Just a short note here, :requirements regexps no longer accept anchors. We have something along these lines:

    map.connect ':controller/:action/:foo', :requirements => { :foo => /^(bar|baz)$/ }

Such that that route only fires if the third url part is exactly bar or baz. To silence 1.2, just remove the ^ and $ anchors.

## Controllers/Views

The instance variables @params, @session, @request, and @flash are deprecated in controllers and views, use the version without the @. Note, don't try and change this globally in your tests, or all hell will break loose. Oddly, assigns(:flash) in a test seems to trigger the warning for accessing @flash.

If you want to have your link\_to go by post instead of get, use :method => :post instead of :post => true.

(Update: This will not throw errors, but won't work in 1.1.6, so wait until you're actually running 1.2 to do this change.)

Rendering with a string (render 'template') is no longer allowed. The deprecation warning says to render :file => 'template' instead, but if you want your code to continue to work in Rails 1.1.6 you'll need to add a :use\_full\_path => true to the call.

start\_form\_tag and end\_form\_tag are now deprecated. The suggested replacement is to pass a block to a form\_tag call, but that does not work at all in Rails 1.1.6. My preferred fix is to use a bare form\_tag to start the form, and a hard-coded to finish it. Same goes with remote\_form\_tag for those AJAXy forms. That shuts up all the deprecation warnings, and allows for a fairly simple multiline regexp to blockify them up in the future. I was looking at something like <%= ?(remote\_)?form\_tag([^%]*) ?%>(.*?) and replacing with \_<% $1form\_tag$2 do %>$3<% end %>

We've got a few places where we're redirecting to a named route: redirect\_to :login\_url. This calls url\_for, which is deprecated. I think the correct solution is to just drop the colon and redirect\_to login\_url, but this doesn't work in 1.1.6 and I haven't quite tested it yet.

## Tests

Lastly, a change which I completely disagree with, assert\_template\_has and friends are now deprecated. Use assert(@response.has\_session\_object?(key)) instead, my ass. This changes removes a useful failure message like <:login> is not a template object and brings me back to the glory days of is not true. I know I'll be rewriting those as custom assertions for my test\_helper, thank you very much.

## To Be Continued

Like I said, I'm only half done this migration, but when I get the rest of it sorted, I'll be posting a follow-up right here. See you then.
