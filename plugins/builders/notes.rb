class Notes < SiteBuilder
  # I want to undo "permalinks: pretty" in notes/
  # but it's not so easy...

  def build
    hook :pages, :post_init, :set_url
  end

  def set_url(page)
    return unless notable?(page)

    parent_dir = page.dir.split('/')[0..-2].join('/')
    url = "#{parent_dir}/#{slugify(page.data[:title])}.html"
    # TODO: Find a better way to do this than mucking with internals
    page.instance_variable_set(:@url, url)
  end

  private

  def notable?(page)
    page.data[:notable]
  end

  def slugify(title)
    title.downcase.gsub(/[^a-z0-9]+/, '-')
  end
end
