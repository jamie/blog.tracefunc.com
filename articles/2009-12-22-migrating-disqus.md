title:  Migrating Disqus
tags:   [blog]

In changing this blog over to jekyll, my urls changed (there's now a trailing slash). Easy enough to tell google about it, just set up redirects, but there's no easy way to tell [Disqus](http://disqus.com/) about it so my comments migrate over.

The good news is that it's pretty straightforward using their API, the only bad news is that I can't delete the new threads auto-generated for the new urls, so I'm just moving them out of the way.

I'm using the [HTTParty](http://httparty.rubyforge.org) gem to wrap API access, like so:

    require 'rubygems'
    require 'httparty'
    require 'json'

    class Disqus
      include HTTParty
      base_uri 'disqus.com'
      format :json
  
      def initialize(key, version='1.1')
        @key = key
        @version = version
      end
  
      def auth
        {:user_api_key => @key, :api_version => @version}
      end
  
      def get(action, opts={})
        result = self.class.get("/api/#{action}/", :query => opts.merge(auth))
        result["message"]
      end

      def post(action, opts={})
        result = self.class.post("/api/#{action}/", :body => opts.merge(auth).to_params)
        p result
        result["message"]
      end
    end

Do note that I'm adding trailing slashes to the api calls to avoid a redirect. Doesn't matter for the GET, but the redirect on POST was causing issues.

With this in hand, I'm grabbing my forum, looping through the threads, and renaming any that have comments (a whopping 3 of them).

    key = "secret" # get yours at http://disqus.com/api/get_my_key/
    disqus = Disqus.new(key)

    forum = disqus.get(:get_forum_list).first # I just have one
    forum_api_key = disqus.get(:get_forum_api_key, :forum_id => forum["id"])

    start = 0 # manual pagination, eww
    loop do
      threads = disqus.get(:get_thread_list, :forum_id => forum["id"], :start => start)
      break if threads.empty?

      threads.each do |thread|
        posts = disqus.get(:get_thread_posts, :thread_id => thread["id"])
        next if !posts.empty?
        
        target_url = thread["url"]+"/"

        # There's another thread in the way...
        if other_thread = disqus.get(
          :get_thread_by_url, 
          :forum_api_key => forum_api_key,
          :url => target_url
        )
          # free up the url we want to use
          disqus.post(
            :update_thread,
            :forum_api_key => forum_api_key,
            :thread_id => other_thread["id"],
            :url => target_url + 'old'
          )
        end

        # update thread url
        disqus.post(
          :update_thread,
          :forum_api_key => forum_api_key,
          :thread_id => thread["id"],
          :url => target_url
        )
      end

      start += 25
    end

Et voilà, old comments are in the right place now.
