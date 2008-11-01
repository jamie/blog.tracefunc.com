module StaticHelper
  def css(file)
    %(<link rel="stylesheet" href="#{file}.css" type="text/css">)
  end
  
  def js(file)
    %(<script type='text/javascript' src="#{file}.js"></script>)
  end
  
  def atom_datestamp(date)
    date = DateTime.parse(date) unless date.kind_of? DateTime
    short = date.strftime('%Y-%m-%dT%H:%M:%S%Z')
    long = date.strftime('%b %e, %Y at %H:%M')
    %|<abbr class="published date" title="#{short}">#{long}</abbr>|
  rescue
    "<abbr>draft</abbr>"
  end
end

Webby::Helpers.register(StaticHelper)