module Builders
  class Notes < SiteBuilder
    # I want to undo "permalinks: pretty" in notes/
    # but it's not so easy...

    def build
      hook :pages, :post_read, :populate_url
    end

    def populate_url(page)
      return unless notable?(page)

      permalink = "notes/#{slugify(page.data.title)}.html"
      page.data.permalink = permalink
    end

    private

    def notable?(page)
      page.data[:notable]
    end

    def slugify(title)
      title.downcase.gsub(/[^a-z0-9]+/, "-")
    end
  end
end
