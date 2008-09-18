module StaticHelper
  def css(file)
    %(<link rel="stylesheet" href="/css/#{file}.css" type="text/css">)
  end
  
  def js(file)
    %(<script type='text/javascript' src="/js/#{file}.js"></script>)
  end
end

Webby::Helpers.register(StaticHelper)