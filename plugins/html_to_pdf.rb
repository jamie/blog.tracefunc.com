# Uses a headless chrome browser to print HTML to pdf as part of the
# build step. Pages need to define `print_html` (path in /output where
# the html file resides) and `print_pdf` (destination path) in frontmatter
# to get picked up by this process.
class HtmlToPdf < SiteBuilder
  def build
    hook :site, :post_write do |site|
      site.collections.pages.resources.select { |page| page.data["print_pdf"] }.each do |page|
        system(
          chrome,
          "--headless", "--disable-gpu", "--no-margins",
          "--print-to-pdf=output#{page.data.print_pdf}",
          "output#{page.data.print_html}"
        )
      end
    end
  end

  def chrome
    @chrome ||= [
      `which google-chrome`.chomp,
      "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
    ].reject(&:empty?).first
  end
end
