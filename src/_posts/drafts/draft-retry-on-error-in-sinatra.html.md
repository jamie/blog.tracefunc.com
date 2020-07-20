---
title: Draft
tags:  []
---

Having trouble with transient errors in a sinatra app led me to the
following:

    error do
      if !@retry
        @retry = true
        # try to recover from the error condition
        # in my case, force a reconnect to mysql
        begin
          @response.status = 200
          invoke { route! }
        rescue ::Exception => boom
          handle_exception!(boom)
        end
      else
        # do regular error stuff like log the
        # error from env['sinatra.error']
      end
    end

