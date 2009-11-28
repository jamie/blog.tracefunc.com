---
title:      REST-less on the Web
created_at: 
tags:       [programming, rails, merb]

directory:  draft
filename:   rest-less-on-the-web
extension:  

layout:     article
filter:
  - markdown
---
In Merb, my preferred routing is this:

    r.match(  "/:controller/:id/:action").to({})
    r.match(%r{/:controller/(\d+)}      ).to(:action => "show", :id => "[2]")
    r.match(  "/:controller/:action"    ).to({})
    r.match(  "/:controller"            ).to(:action => "index")
