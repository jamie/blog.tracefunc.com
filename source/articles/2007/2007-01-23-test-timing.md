title:  Test Timing
tags:   [programming, rails]

Since [Geoff's][] gem wasn't working for me, I whipped up a test timing utility based off of it.

Rather than hook into Test::Unit::TestSuite, I'm hooking into TestCase, and providing a global report via an at\_exit hook. Just add the following file to your lib folder, require it from test\_helper, and most of the time it will just sit there, quietly doing nothing. Call it into action by setting the environment variable TEST\_TIMER with a float, and it will output the elapsed time of any test taking longer than that.

Example run:

    # TEST_TIMER=0.25 rake test:units TEST=test/unit/creative_test.rb
    /usr/bin/rake:17:Warning: require_gem is obsolete.  Use gem instead.
    (in /home/jamie/dev/redvase)
    /usr/bin/ruby1.8 -Ilib:test "/usr/lib/ruby/gems/1.8/gems/rake-0.7.1/lib/rake/rake_test_loader.rb" "test/unit/creative_test.rb"
    Loaded suite /usr/lib/ruby/gems/1.8/gems/rake-0.7.1/lib/rake/rake_test_loader
    Started
    ......................................................................................
    Finished in 10.116575 seconds.
    
    86 tests, 164 assertions, 0 failures, 0 errors
    
    Test Benchmark Results
      0.2927 CreativeTest#test_delayed_click_count_with_third_party_stats
      0.2982 CreativeTest#test_impression_count_for_date_range_with_third_party_stats_offset
      0.3240 CreativeTest#test_global_creative_stats_should_return_correct_default_values
      6.2505 CreativeTest#test_click_count

Source file, lib/test_timer.rb

    if ENV.has_key? 'TEST_TIMER' and
       !Test::Unit::TestCase.method_defined? :untimed_run
    
      class Test::Unit::TestCase
        cattr_reader :benchmark_data
        @@benchmark_data = {}
        alias untimed_run run
    
        def run(result, &progress_block)
          start = Time.now
          untimed_run(result, &progress_block)
          finish = Time.now
          elapsed = finish - start
          if elapsed > ENV['TEST_TIMER'].to_f
            name =~ /(.*)\((.*)\)/
            @@benchmark_data["#{$2}##{$1}"] = elapsed
          end
        end
      end
    
      # at_exit hooks run in reverse order, so in order to run after
      # Test::Unit's hook, we need to nest at_exit calls.
      at_exit do
        at_exit do
          results = Test::Unit::TestCase.benchmark_data
          unless results.empty?
            puts "\nTest Benchmark Results"
            results.sort{|a,b| a.last <=> b.last }.each do |key,value|
              puts " %7.4f #{key}" % value
            end
          end
        end
      end
    end


[Geoff's]: http://www.oreillynet.com/ruby/blog/2006/10/test_tidbits.html

