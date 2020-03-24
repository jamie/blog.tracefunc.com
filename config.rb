###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page "/path/to/file.html", layout: :otherlayout

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

ignore "/article.html.erb"

# General configuration

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
end

###
# Helpers
###

activate :directory_indexes

activate :blog do |blog|
  # This will add a prefix to all links, template references and source paths
  # blog.prefix = "blog"

  blog.permalink = "{year}/{month}/{day}/{title}"
  # Matcher for blog source files
  blog.sources = "articles/{year}-{month}-{day}-{title}"
  # blog.taglink = "tags/{tag}.html"
  blog.layout = "article"
  # blog.summary_separator = /(READMORE)/
  # blog.summary_length = 250
  # blog.year_link = "{year}.html"
  # blog.month_link = "{year}/{month}.html"
  # blog.day_link = "{year}/{month}/{day}.html"
  # blog.default_extension = ".markdown"

  blog.tag_template = "tag.html"
  blog.calendar_template = "calendar.html"

  # Enable pagination
  # blog.paginate = true
  # blog.per_page = 10
  # blog.page_link = "page/{num}"
end

page "/feed.xml", layout: false

class Wiki < Middleman::Extension
  # TODO: {{wikilinks}}
  option :path, //, 'Path to apply manipulations'

  def initialize(app, options_hash={}, &block)
    super
  end

  def manipulate_resource_list(resources)
    resources.each do |r|
      next unless r.path =~ options.path

      r.metadata[:options][:layout] = "notes"
      r.metadata[:options][:content_type] = "text/html"

      pagename = r.path.split('/').last
      r.metadata[:page][:pagename] = pagename

      if r.metadata.dig(:page, :title).blank?
        title = r.path.split('/').last.gsub('_',' ').titleize
        r.metadata[:page][:title] = title
      end
    end

    resources
  end

  helpers do
    def pages_linking_here
      pagename = current_page.metadata.dig(:page, :pagename)
      linking_here = sitemap.resources.select do |r|
        r.path =~ /notes/ && File.read(r.source_file) =~ /{{#{pagename}}}/i
      end
    end
  end
end
::Middleman::Extensions.register(:wiki, Wiki)

activate :wiki, path: %r{^notes/}

# Methods defined in the helpers block are available in templates
helpers do
  def format_date(date)
    format = case date.day
    when 1, 21, 31
      '%B %est %Y'
    when 2, 22
      '%B %end %Y'
    when 3, 23
      '%B %erd %Y'
    else
      '%B %eth %Y'
    end
    date.strftime(format)
  end
end

# Build-specific configuration
configure :build do
  # Minify CSS on build
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript
end
