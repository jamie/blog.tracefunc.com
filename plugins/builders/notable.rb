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
