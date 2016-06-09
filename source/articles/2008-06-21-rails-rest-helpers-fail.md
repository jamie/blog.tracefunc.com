title:  Rails REST Helpers Fail
tags:   [rails]

This is why I hate Rails' hackery to interact RESTfully from the browser, where it's not exactly natively supported.

    link_to 'Destroy', post_path(post), :method => :delete

Specifying the HTTP verb to use (and then passing it as _method in the query string) is superfluous.  If I tell Rails to use restful routes, I should be able to leave it in Rails' hands to treat DELETE /posts/42 and POST /posts/42/delete as the same controller/action.  Shoehorning hacks to make the browser behave is the wrong integration point.

Less so is the redundancy that occurs with post_path(post).

I'll expand on the solution I'm using for route helpers in Merb in my next post.

