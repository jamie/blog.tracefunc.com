module Jekyll
  module Filters
    def is_null(input)
      input.nil?
    end
    
    def keys(input)
      input.keys
    end
    
    def tagged(input, tag)
      input.select{|post| post.tags.include? tag}
    end
    
    def year(input)
      input['date'].year
    end
  end
end
