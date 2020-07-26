class Notable < SiteBuilder
  LINK_PATTERN = %r{\[\[([^\]]+)\]\]}
  CONFIG_DEFAULTS = {
    notable: {
      root: 'notes'
    }
  }

  def build
    liquid_filter "wikilink", :wikilink
  end
  
  def wikilink(content)
    content ||= ""
    content.gsub(LINK_PATTERN) do |match|
      # For some reason I can't use last_match via the gsub call, so let's re-match
      match =~ LINK_PATTERN

      title = Regexp.last_match[1]
      page = title.gsub(' ', '+')
      href = [root, page].compact.join('/')
      %(<a href="/#{href}/" class="wikilink">#{title}</a>)
    end
  end

  def root
    config[:notable][:root]
  end
end

__END__


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
