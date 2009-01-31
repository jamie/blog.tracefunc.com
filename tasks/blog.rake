class BlogPage
  def initialize(filename)
    _, headers, @body = File.read(filename).split(/---\r?\n/)
    @headers = YAML.load(headers)
  end
  
  def title
    @headers['title']
  end
end

namespace :blog do
  desc 'Create a new draft titled [NAME]'
  task :new do
    page, title, dir = Webby::Builder.new_page_info
    basename = File.basename(page)
    ext = "md" # for markdown syntax highlight
    target = File.join(dir, 'blog', 'draft-' + basename + ".#{ext}")
    
    result = Webby::Builder.create(
      target,
      :from => 'templates/blog.md',
      :locals => {
        :title => title,
        :basename => basename
      }
    )
    unless Webby.editor.nil?
      editor = Webby.editor
      editor = 'mate' if editor == 'mate -w'
      `#{editor} #{result}`
    end
  end
  
  desc 'List current draft posts'
  task :drafts do
    Dir['content/blog/draft*'].each_with_index do |draft, id|
      page = BlogPage.new(draft)
      puts "%2d  %s" % [id, page.title]
    end
  end
  
  desc 'Publish draft #N (see blog:drafts)'
  task :publish do |id|
    p id
    puts 'publish post'
  end
  
  desc 'Publish draft #N (see blog:drafts), then publish site'
  task :publish! do
    Rake::Task['blog:publish'].invoke
    Rake::Task['publish'].invoke
  end
end
