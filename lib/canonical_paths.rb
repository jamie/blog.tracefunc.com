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
