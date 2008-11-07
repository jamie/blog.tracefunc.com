---
title:      Article Title
created_at: 
tags:       [tags]

directory:  draft
filename:   permalink
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
