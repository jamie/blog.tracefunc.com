class Notable < SiteBuilder
  LINK_PATTERN = %r{\[\[([^\]]+)\]\]}

  def build
    hook :pages, :post_init, :set_url
    generator :build_backlinks
    generator :render_wikilinks
    # TODO: Attachments if/when I start using them in Notable
  end

  def set_url(page)
    return unless notable?(page)

    parent_dir = page.dir.split('/')[0..-2].join('/')
    url = "#{parent_dir}/#{slugify(page.data[:title])}.html"
    # TODO: Find a better way to do this than mucking with internals
    page.instance_variable_set(:@url, url)
  end

  def build_backlinks
    notable_pages.each do |page|
      pagename = page.data[:title]
      backlinks = site.pages.select {|pg| pg.content =~ /\[\[#{pagename}\]\]/i }
      page.data[:backlinks] = backlinks if backlinks.any?
    end
  end

  def render_wikilinks
    notable_pages.each do |page|
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

private
  def notable_pages
    site.pages.select { |page| notable?(page) }
  end

  def notable?(page)
    page.data[:notable]
  end

  def slugify(title)
    title.downcase.gsub(/[^a-z0-9]+/, '-')
  end
end
