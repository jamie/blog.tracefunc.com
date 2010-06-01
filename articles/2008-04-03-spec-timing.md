title:  Spec Timing
tags:   [programming, ruby]

As an update to a [previous article](http://blog.tracefunc.com/2007/01/23/test-timing),

    if $specs_timed.nil? && ENV.has_key?('SLOW')
      $specs_timed = true
      $timings = []

      Spec::Example::ExampleGroup.prepend_before do
        @start = Time.now
      end
      Spec::Example::ExampleGroup.append_after do
        elapsed = Time.now - @start
        if elapsed > ENV['SLOW'].to_f
          $timings << [elapsed, "#{self.class.description} #{description}"]
        end
      end

      at_exit do
        puts "\nSlow Specs:"
        $timings.sort{|a,b| a.first <=> b.first}.each do |time, name|
          puts " %7.4f #{name}" % time
        end
        puts "  None!" if $timings.empty?
      end
    end

Then, simply run

    rake SLOW=0.1

Two gotchas if you're using Rails though: instead of hooking S::E::ExampleGroup, you'll need to hook Spec::Rails::Example::RailsExampleGroup.  Second, if you have any spec failures the timings don't seem to get output, since spec/rails aborts execution after failing.

