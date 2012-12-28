require 'rubygems'
require 'bundler/setup'

require 'toto'
require 'rack-rewrite'

use Rack::Rewrite do
  r301 %r{/(\d+/\d+/\d+/.*[^/])$}, '/$1/'
  rewrite '/atom.xml', '/index.xml'

  # For www cloning
  rewrite '/', '/www/index.html', :host => 'tracefunc.com'
  rewrite %r{/(.+)}, '/www/$1', :host => 'tracefunc.com'
end

# Rack config
use Rack::Static, :urls => ['/css', '/js', '/images', '/static', '/www', '/favicon.ico'], :root => 'public'
use Rack::CommonLogger

if ENV['RACK_ENV'] == 'development'
  use Rack::ShowExceptions
end

toto = Toto::Server.new do
  #
  # Add your settings here
  # set [:setting], [value]
  # 
  # set :root,      "index"                                   # page to load on /
  # set :date,      lambda {|now| now.strftime("%d/%m/%Y") }  # date format for articles

  set :url,       'http://blog.tracefunc.com'

  set :author,    'Jamie Macey'
  set :email,     'jamie.blog@tracefunc.com'
  set :title,     'set_trace_func'
  set :markdown,  true
  set :disqus,    'tracefunc'
  set :ext,       'md'
  set :summary,   :delim => /~~/, :max => nil
  # returns an html, from a path & context
  set :to_html, (lambda {|path, page, ctx|
    if File.exist?("#{path}/#{page}.rhtml")
      ERB.new(File.read("#{path}/#{page}.rhtml")).result(ctx)
    elsif File.exist?("#{path}/#{page}.md")
      text = File.read("#{path}/#{page}.md")

      yaml, body = text.split("\n\n", 2)
      meta = YAML.load(yaml) rescue ""
      meta, body = {}, text unless meta.kind_of? Hash # implies no yaml preamble

      # VOODOO! Pull the extracted YAML preamble out, and merge into the parent page
      eval "@context.merge!(#{meta.inspect})", ctx
      Toto::Site::Context.new(meta, self, "#{path}/#{page}.md").markdown body
    end
  })


  set :date, lambda {|now| now.strftime("%B #{now.day.ordinal} %Y") }
end
run toto
