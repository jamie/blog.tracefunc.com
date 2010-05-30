require 'toto'
require 'lib/canonical_paths'

# Rack config
use Rack::Static, :urls => ['/css', '/js', '/images', '/favicon.ico'], :root => 'public'
use Rack::CommonLogger

if ENV['RACK_ENV'] == 'development'
  use Rack::ShowExceptions
end

use CanonicalPaths

toto = Toto::Server.new do
  #
  # Add your settings here
  # set [:setting], [value]
  # 
  # set :root,      "index"                                   # page to load on /
  # set :date,      lambda {|now| now.strftime("%d/%m/%Y") }  # date format for articles

  set :author,    'Jamie Macey'
  set :email,     'jamie.blog@tracefunc.com'
  set :title,     'set_trace_func'
  set :markdown,  true
  set :disqus,    'tracefunc'
  set :ext,       'md'
  set :summary,   :delim => /~~/, :max => nil

  set :date, lambda {|now| now.strftime("%B #{now.day.ordinal} %Y") }
end
run toto
