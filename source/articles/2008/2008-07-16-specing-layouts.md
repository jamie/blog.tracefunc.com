---
title:  Specing Layouts
tags:   [merb, specs]
---

Just a quick little snippet for those trying to write specs for their layout.

Create your spec in `spec/views/layout/application.html.erb_spec.html`, and add this class to it:

    class Layout < Application
      layout nil
      def application; render; end
    end

Then just test it as you would any other ordinary view.

