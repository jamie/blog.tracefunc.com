class Notable < SiteBuilder
  LINK_PATTERN = %r{\[\[([^\]]+)\]\]}
  CONFIG_DEFAULTS = {
    notable: {
      root: 'wiki'
    }
  }

  def root
    config[:notable][:root]
  end

  def build
    hook :pages, :post_init, :set_frontmatter_defaults
    generator :build_backlinks
    generator :render_wikilinks
  end

  def build_backlinks
    each_page do |page|
      pagename = page.data[:title]
      backlinks = site.pages.select {|pg| pg.content =~ /\[\[#{pagename}\]\]/i }
      page.data[:backlinks] = backlinks if backlinks.any?
    end
  end
  
  def render_wikilinks
    each_page do |page|
      page.content.gsub!(LINK_PATTERN) do |match|
        # For some reason I can't use last_match via the gsub call, so let's re-match
        match =~ LINK_PATTERN

        title = Regexp.last_match[1]
        link = site.pages.detect {|pg| pg.data[:title] == title}
        if link
          %(<a href="#{link.url}" class="wikilink">#{link.data[:title]}</a>)
        else
          title
        end
      end
    end
  end

  def set_frontmatter_defaults(page)
    return unless page.dir.match(%r{^/#{root}})
    parent_dir = page.dir.split('/')[0..-2].join('/')
    url = "#{parent_dir}/#{slugify(page.data[:title])}.html"
    page.instance_variable_set(:@url, url)
  end

private
  def each_page
    site.pages.each do |page|
      next unless page.data[:categories] == 'notable'
      yield page
    end
  end

  def slugify(title)
    title.downcase.gsub(/[^a-z0-9]+/, '-')
  end
end
