title:      REST-less on the Web
tags:       [programming, rails, merb]

In Merb, my preferred routing is this:

    r.match(  "/:controller/:id/:action").to({})
    r.match(%r{/:controller/(\d+)}      ).to(:action => "show", :id => "[2]")
    r.match(  "/:controller/:action"    ).to({})
    r.match(  "/:controller"            ).to(:action => "index")
