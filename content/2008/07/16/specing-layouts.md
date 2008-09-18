--- 
title:      Specing Layouts
created_at: 2008-07-16 16:37:00 -04:00
extension:  html
layout:     article
tags:       [merb, specs]
filter:
  - markdown
--- 
Just a quick little snippet for those trying to write specs for their layout.

Create your spec in `spec/views/layout/application.html.erb_spec.html`, and add this class to it:

    class Layout < Application
      layout nil
      def application; render; end
    end

Then just test it as you would any other ordinary view.
