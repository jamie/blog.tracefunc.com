class HtmlToPdf < SiteBuilder
  def build
    hook :site, :post_write do |site|
      site.pages.select { |page| page.data['print_pdf'] }.each do |page|
        chrome = `which google-chrome`.chomp
        chrome = "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" if chrome.empty?
        system(
          chrome,
          "--headless",
          "--disable-gpu",
          "--no-margins",
          "--print-to-pdf=output#{page.data.print_pdf}",
          "output#{page.data.print_html}"
        )
      end
    end
  end
end
