namespace :blog do
  FileList["#{Webby.site.template_dir}/blog/*"].each do |template|
    next unless test(?f, template)
    name = template.pathmap('%n')
    next if name =~ %r/^(month|year)$/  # skip month/year blog entries

    desc "Create a new blog #{name}"
    task name do |t| #=> [:create_year_index, :create_month_index] do |t|
      page, title, dir = Webby::Builder.new_page_info
      dir = File.join(dir, 'blog')

      page = File.join(dir, Time.now.strftime('draft-') + File.basename(page))
      page = Webby::Builder.create(page, :from => template,
                 :locals => {:title => title, :directory => dir})
      exec(::Webby.editor, page) unless ::Webby.editor.nil?
    end
  end
  
  def create_from_template(dir_fmt, template)
    _, _, dir = Webby::Builder.new_page_info
    dir = File.join(dir, Time.now.strftime(dir_fmt))

    fn = File.join(dir, 'index.haml')
    tmpl = Dir.glob(File.join(Webby.site.template_dir, template)).first.to_s

    if test(?f, tmpl) and not test(?f, File.join(Webby.site.content_dir, fn))
      Webby::Builder.create(fn, :from => tmpl, :locals => {:directory => dir})
    end
  end

  task :create_year_index do |t|
    create_from_template('%Y', 'blog/year.*')
  end

  task :create_month_index do |t|
    create_from_template('%Y/%m', 'blog/month.*')
  end
end
