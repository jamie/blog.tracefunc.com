# Roda is a simple Rack-based framework with a flexible architecture based
# on the concept of a routing tree. Bridgetown uses it for its development
# server, but you can also run it in production for fast, dynamic applications.
#
# Learn more at: http://roda.jeremyevans.net

# Uncomment to use file-based dynamic routing in your project (make sure you
# uncomment the gem dependency in your Gemfile as well):
# require "bridgetown-routes"

class RodaApp < Roda
  plugin :bridgetown_server

  # Uncomment to use Bridgetown SSR:
  # plugin :bridgetown_ssr

  # And optionally file-based routing:
  # plugin :bridgetown_routes

  route do |r|
    r.bridgetown
  end
end
