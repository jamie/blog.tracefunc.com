class ExcerptSummary
  module RubyResource
    def summary_extension_output
      return unless site.config['excerpt_separator']
      content.split(site.config['excerpt_separator']).first
    end
  end
end

Bridgetown::Resource.register_extension ExcerptSummary
