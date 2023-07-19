Bridgetown.configure do |config|
  init :"bridgetown-feed" do
    config.feed = {path: "index.xml"}
  end

  # add configuration here

  url "https://blog.tracefunc.com" # the base hostname & protocol for your site, e.g. https://example.com

  # Other options you might want to investigate:
  #
  # base_path: "/" # the subpath of your site, e.g. /blog. If you set this option,
  # ensure you use the `relative_url` helper for all links and assets in your HTML.
  # If you're using esbuild for frontend assets, edit `esbuild.config.js` to
  # update `publicPath`.

  # timezone: America/Los_Angeles

  # pagination:
  #   enabled: true

  permalink "pretty"
  config.template_engine = "liquid"

  excerpt_separator "<!-- EXCERPT -->"

  config.kramdown = {syntax_highlighter_opts: {block: {line_numbers: true}}}

  config.defaults = [
    {
      # an empty path means all files in the project
      scope: {path: "", type: "posts"},
      values: {layout: "post", render_with_liquid: false}
    },
    {
      scope: {path: "_posts/drafts/"},
      values: {published: false}
    },
    {
      scope: {path: "notes/"},
      values: {notable: true, layout: "notable"}
    }
  ]
end
