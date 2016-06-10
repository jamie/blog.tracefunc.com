---
title:  Recursiveness
tags:   [programming, ruby]
---

One of the big things I learned at University was that while "Recursion is a Wonderful Thing" (Thank you, Dr. Roelants), sometimes the performance can really hurt. Those times, it can pay to spend the effort turning that recursive function into a simple loop. Sure, it might not be as clean, or as elegant, or as natural to understand, but we're looking at performance here, right?

Ryan Davis recently [posted][] about using RubyInline to optimize a recursive factorial method. He ended with a caveat that sometimes you need to look at other things than just moving the code into C for speed. His idea was to cache the data as it goes along. There are times when that won't help you in the log run (for example, generating a stats graph where caching as you draw helps, but the cached values will be stale the next time you need to do it) but changing it around to iterative can sometimes give you a further speedup.

    def fib_iter(n)
      return 1 if n < 3  
      f = f1 = 1
      (2..n).each do
        f, f1 = (f+f1), f
      end
      f
    end

The benchmarking speaks for itself. (Same parameters as Ryan's benching, 10,000 runs doing fib(15)):

                          user     system      total        real
    fib-ruby         21.180000   3.640000  24.820000 ( 24.989140)
    fib-hash-reset    0.510000   0.070000   0.580000 (  0.609976)
    fib-cache-reset   0.510000   0.050000   0.560000 (  0.570715)
    fib-iter          0.160000   0.020000   0.180000 (  0.209565)
    fib-hash          0.020000   0.000000   0.020000 (  0.034616)
    fib-cached        0.020000   0.010000   0.030000 (  0.035222)

Benchmarks for fib-ruby and fib-cached come from Ryan's post. fib-iter and fib-hash are mine.

The two "-reset" methods are indicative of times when global caching won't help you, which is still a significant speedup over the uncached versions. (For fib(15), uncached will need ~610 method calls, compared to ~15) The iterative method is about 1/3 their speed, but when you can globally cache you can get huge gains - if I increased the number of runs in the benchmark, the discrepancy between fib-iter and fib-cached would increase even more.

So once again, it seems that there's a different best solution for two different problems.

And the fib-hash benchmark? It's not significantly faster than Ryan's fib-cached method, but it bumps the fib logic from a method that uses a hash into the hash itself. It's a neat trick I picked up a while ago, but probably too ugly to make significant use of unless your benchmarking tells you otherwise - it's really hard to read at first glance:

    def hashfib(n)
      return 1 if n <= 1
      h = Hash.new{|h,k| h[k] = h[k-1] + h[k-2] }
      h[1] = 1
      h[2] = 1
      h[n]
    end

The cached version uses @@h instead of h, and ||=s it.

[posted]: http://blog.zenspider.com/archives/2006/09/recursive_functions_in_rubyinline.html

