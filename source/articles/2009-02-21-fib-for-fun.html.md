---
title:  Fib for Fun
tags:   [programming]
---

A little math can be a dangerous thing.  Here's a quick benchmark for Fibonacci numbers (Y axis in seconds, 20,000 iterations):

![Graph](http://img.skitch.com/20090222-p4e42eew9gbknfis86pdms813f.png)

The line on the left, marked A, is the typical naive recursive solution, based as directly as possible on the mathematical definition of the function:

~~~ruby
def fib_r(n)
  return 1 if n <= 2
  fib_r(n-1) + fib_r(n-2)
end
~~~

Note the telltale exponential curve - this is what we call Very Bad.  The line there stops at Fib(10).

A little jiggery lets us convert the recursive solution into an iterative one, line B:

~~~ruby
def fib_i(n)
  x = y = 1
  (n-1).times do
    x, y = y, x+y
  end
  x
end
~~~
My personal favorite Fib function is (ab)using a hash's default value function to act as a memoizer.  Line C is the fastest of the bunch (constant time of ~0.012s) but does have some extra memory overhead.

~~~ruby
def fib_h(n)
  @h ||= Hash.new{ |h,k|
    if k < 2
      h[k] = k
    else
      h[k] = h[k-1] + h[k-2]
    end
  }
  @h[n]
end
~~~

If we were in an embedded system or something, the memory overhead would probably be bad, but fear not!  Math can save us!

Line D is also constant time, but about 0.037s.  It's a fun little bit of math mentioned in [SICP][], and turns Fibonacci numbers into a very simple (if unintuitive) bit of math:

~~~ruby
SQRT5 = Math.sqrt(5.0)
PHI = (1 + SQRT5) / 2
PSI = (1 - SQRT5) / 2

def fib_m(n)
  ((PHI ** n - PSI ** n) / SQRT5).to_i
end
~~~

[SICP]: http://mitpress.mit.edu/sicp/
