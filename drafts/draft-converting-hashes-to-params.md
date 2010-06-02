title:      Converting Hashes to Params
tags:       [ruby, rails, merb]

When...

    def hash_to_params(hsh, base_key="")
      hsh.map do |k, v|
        next if [:action, :controller].include?(k) && base_key.empty?
        case v
        when Hash:
          hash_to_params(v, params_key(base_key, k))
        when Array:
          array_to_params(v, params_key(base_key, k))
        else
          "#{params_key(base_key, k)}=#{CGI.escape v.to_s}"
        end
      end.compact.join('&')
    end
  
    def array_to_params(ary, base_key="")
      ary.map{|v| "#{base_key}[]=#{CGI.escape v}"}.join('&')
    end

    def params_key(current, addition)
      current.blank? ? addition.to_s : "#{current}[#{CGI.escape addition.to_s}]"
    end
