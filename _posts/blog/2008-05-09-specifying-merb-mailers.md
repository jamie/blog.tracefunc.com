---
title:      Specifying Merb Mailers
created_at: 2008-05-09 20:18:00 -0400
tags:       [programming, merb, specs]

directory:  2008/05/09
filename:   specifying-merb-mailers
extension:  

layout:     article
filter:
  - markdown
---
This helper is based on some other controller/view helpers I've been working on and planning on blogging soon, with a nod to the specs present in the merb-mailer library itself.

I'm still considering the idea of separate specs for UserMailer and its views, but I think the overhead is too much for mailers, compared to the benefits we get for regular controllers/views.  I think this is a result of the way the send_mail helper functions.

### in a controller

    send_mail UserMailer, :hello, {
      :from => "greeter@example.com",
      :to => @person.email,
      :subject => "Greetings"
    }, {
      :name => @person.name
    }

The controller spec can simply stub/mock the send_mail call as appropriate.

### spec/spec_helper.rb

    Merb::Mailer.delivery_method = :test_send
    def describe_mail(mailer, template, &block)
      describe "/#{mailer.to_s.downcase}/#{template}" do
        before :each do
          @mailer_class, @template = mailer, template
          @assigns = {}
        end
    
        def deliver(send_params={}, mail_params={})
          mail_params = {:from => "from@example.com", :to => "to@example.com", :subject => "Subject Line"}.merge(mail_params)
          @mailer_class.new(send_params).dispatch_and_deliver @template.to_sym, mail_params
          @mail = Merb::Mailer.deliveries.last
        end
    
        instance_eval &block
      end
    end

### spec/mailers/user\_mailer\_spec.rb

    require File.join(File.dirname(__FILE__),'..','spec_helper')
    
    describe_mail UserMailer, :hello do
      it "should say hello" do
        deliver :name => "Jamie"
        @mail.text.should == "Hello Jamie"
      end
    end

I'm a big fan of custom rspec describers, as above.  The fact that before and after blocks are transparently inherited is a *huge* win over test/unit, where you'd need to explicitly call super.

### app/mailers/user_mailer.rb

    class UserMailer < Merb::MailController
      def hello
        render_mail
      end  
    end

### app/mailers/views/user_mailer/hello.text.erb

    Hello <%= params[:name] %>

