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
  blog.layout = "layouts/article"
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
  option :root, 'wiki', 'Root path for the wiki'
  expose_to_template :wikilink!

  def initialize(app, options_hash={}, &block)
    super
  end

  def after_configuration
    app.sitemap.resources.each do |r|
      next unless r.path =~ %r{^#{options.root}/}
      app.config_context.ignore r.path
      app.config_context.proxy "#{r.path}.html", r.path, directory_index: false
    end
  end

  def manipulate_resource_list(resources)
    resources.each do |r|
      next unless r.path =~ %r{^#{options.root}/}

      # General metadata
      r.metadata[:options][:layout] = "notes"
      r.metadata[:options][:content_type] = "text/html"

      # Auto-generate some frontmatter
      r.metadata[:page][:pagename] = r.path.split('/').last

      if r.metadata.dig(:page, :title).blank?
        title = r.path.split('/').last.gsub('_',' ').titleize
        r.metadata[:page][:title] = title
      end
    end

    resources
  end

  LINK_PATTERN = %r{\[\[([^\]]+)\]\]}
  def wikilink!(source)
    source.gsub(LINK_PATTERN) do |match|
      # For some reason I can't use last_match via the gsub call, so let's re-match
      match =~ LINK_PATTERN

      page = Regexp.last_match[1]
      %(<a href="/#{options.root}/#{page}.html" class="wikilink">#{page}</a>)
    end
  end

  helpers do
    def pages_linking_here
      pagename = current_page.metadata.dig(:page, :pagename)
      return [] unless pagename

      linking_here = sitemap.resources.sort_by(&:path).select do |r|
        r.path =~ /notes/ && File.read(r.source_file) =~ /\[\[#{pagename}\]\]/i
      end
    end
  end
end
::Middleman::Extensions.register(:wiki, Wiki)

activate :wiki, root: 'notes'

activate :external_pipeline,
  name: :webpack,
  command: build? ? './node_modules/webpack/bin/webpack.js --bail' : './node_modules/webpack/bin/webpack.js --watch -d --color',
  source: ".tmp/dist",
  latency: 1

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
