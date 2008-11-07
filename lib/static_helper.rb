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
  
  def by_year(articles)
    articles.inject({}) do |hash, article|
      year = Time.parse(article.created_at).year
      hash[year] ||= []
      hash[year] << article
      hash
    end
  end

  def by_tag(articles)
    articles.inject({}) do |hash, article|
      article.tags.each do |tag|
        hash[tag] ||= []
        hash[tag] << article
      end
      hash
    end
  end
  
  def by_status(projects)
    projects.inject({}) do |hash, project|
      hash[project.status] ||= []
      hash[project.status] << project
      hash
    end
  end
end

Webby::Helpers.register(StaticHelper)