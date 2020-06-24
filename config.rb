## Page options, layouts, aliases and proxies

# Non-html, skip layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

## General configuration

configure :development do
  # Reload the browser automatically whenever files change
  activate :livereload
end

activate :directory_indexes
activate :syntax, line_numbers: true

set :markdown, fenced_code_blocks: true

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

## Blog Config

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

## Wiki Config

class Wiki < Middleman::Extension
  option :root, 'wiki', 'Root path for the wiki'
  expose_to_template :wikilink!

  def initialize(app, options_hash={}, &block)
    super
  end

  def after_configuration
    app.sitemap.resources.each do |r|
      next unless r.path =~ %r{^#{options.root}/}
      app.config_context.ignore r.path

      title, *path = r.path.split('/').reverse
      page = title.downcase.gsub(/ +/, '-')
      full_path = [page, *path].reverse.join('/')

      app.config_context.proxy "#{full_path}.html", r.path, directory_index: false
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

      title = Regexp.last_match[1]
      page = title.downcase.gsub(/ +/, '-')
      %(<a href="/#{options.root}/#{page}.html" class="wikilink">#{title}</a>)
    end
  end

  helpers do
    def pages_linking_here
      pagename = current_page.metadata.dig(:page, :pagename)
      return [] unless pagename

      sitemap.resources.sort_by(&:path).select do |r|
        r.path =~ /notes/ && File.read(r.source_file) =~ /\[\[#{pagename}\]\]/i
      end
    end
  end
end
::Middleman::Extensions.register(:wiki, Wiki)

activate :wiki, root: 'notes'

## Build Pipeline

activate :external_pipeline,
  name: :webpack,
  command: build? ? 'npm run build' : 'npm run start',
  source: '.tmp/dist',
  latency: 1

# Build-specific configuration
configure :build do
  # Minify CSS on build
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript
end
