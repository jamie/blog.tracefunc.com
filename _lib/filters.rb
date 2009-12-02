require 'ftools'

module Jekyll
  module Filters
    def keys(input)
      input.keys
    end
    
    def last_of_year(post)
      post['next'].nil? or post['next'].date.year != post['date'].year
    end
    
    def now(_)
      Time.now
    end
    
    def tagged(input, tag)
      input.select{|post| post.tags.include? tag}
    end
    
    def to_i(o)
      o.to_i
    end
    
    def updated(post)
      File.mtime(Dir['_posts/' + post['id'][1..-1].gsub('/','-') + '.*'].first)
    end
    
    def year(input)
      input['date'].year
    end
  end
end
