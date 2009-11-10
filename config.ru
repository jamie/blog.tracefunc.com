# I don't have file extensions on entry permalinks
Rack::Mime::MIME_TYPES.merge!("" => "text/html")

class DefaultIndexFile
  def initialize(app, &block)
    @app = app
    yield self if block_given?
  end
  
  def call(env)
    env['PATH_INFO'] << 'index.html' if env['PATH_INFO'] =~ %r{/$}
    @app.call(env)
  end
end

use DefaultIndexFile

run Rack::File.new('output')
