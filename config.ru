require 'toto'

# Rack config
use Rack::Static, :urls => ['/css', '/js', '/images', '/favicon.ico'], :root => 'public'
use Rack::CommonLogger

if ENV['RACK_ENV'] == 'development'
  use Rack::ShowExceptions
end

class CanonicalPaths
  def initialize(app, &block)
    @app = app
    yield self if block_given?
  end
  
  def call(env)
    if env['PATH_INFO'] =~ %r(/[0-9]{4}/[0-9]{2}/[0-9]{2}/[^/]+$)
      Rack::Response.new([], 301, {'Location' => env['PATH_INFO']+'/'}).finish
    else
      @app.call(env)
    end
  end
end
use CanonicalPaths

toto = Toto::Server.new do
  #
  # Add your settings here
  # set [:setting], [value]
  # 
  # set :author,    ENV['USER']                               # blog author
  # set :title,     Dir.pwd.split('/').last                   # site title
  # set :root,      "index"                                   # page to load on /
  # set :date,      lambda {|now| now.strftime("%d/%m/%Y") }  # date format for articles
  # set :summary,   :max => 150, :delim => /~/                # length of article summary and delimiter

  set :markdown,  true
  set :disqus,    'tracefunc'
  set :ext,       'md'

  set :date, lambda {|now| now.strftime("%B #{now.day.ordinal} %Y") }
end
run toto
