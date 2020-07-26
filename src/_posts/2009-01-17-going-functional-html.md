---
title:  Going Functional
tags:   [clojure, sicp]
---

So, some [Hacker News][] users recently [decided][] that it'd be a good idea to [work through][] the [SICP][] together and make a kind of book club out of the deal over irc.

When I heard of it, I thought it'd be a good excuse to work through the text myself (since it was just sitting on my bookshelf), and also stretch my brain a bit more teaching myself [Clojure][].  I'm almost done the reading and [exercises][] for section 1.1, and I'm already finding it a valuable exercise.

[Hacker News]: http://news.ycombinator.com/
[decided]: http://news.ycombinator.com/item?id=428248
[work through]: http://groups.google.com/group/hacker-news-reads-sicp/
[SICP]: http://mitpress.mit.edu/sicp/
[Clojure]: http://clojure.org/
[exercises]: http://github.com/jamie/sicp/

The third exercise asks us to "define a procedure that takes three numbers as arguments and returns the sum of the squares of the two larger numbers."  At either extremity are two solutions.  The straightforward solution a new programmer can generate based solely on the first 20 pages of the text looks something like this:

~~~clojure
(defn sum-largest-squares [a b c]
  (cond (and (< a b) (< a c)) (+ (* b b) (* c c))
        (and (< b a) (< b c)) (+ (* a a) (* c c))
        (and (< c a) (< c b)) (+ (* a a) (* b b))))
~~~

Some tests to prove correctness, returning 2^2 + 3^2, or 13, are:

~~~clojure
(sum-largest-squares 1 2 3)
(sum-largest-squares 2 3 1)
(sum-largest-squares 3 1 2)
~~~

An interesting (and enlightening) exercise is to take our naive function, and just start randomly refactoring, and see where it takes us.  One step at a time, making sure we are always passing our handful of test cases.  The goal is to decompose and abstract the function into more manageable pieces, with less repetition.  To start:

~~~clojure
(defn sum-largest-squares [a b c]
  (cond (and (< a b) (< a c)) (+ (square b) (square c))
        (and (< b a) (< b c)) (+ (square a) (square c))
        (and (< c a) (< c b)) (+ (square a) (square b))))
~~~

The square function is trivially pulling out (* x x), and conveniently is already present in Clojure.

Second step is to pull out the three conditional clauses into sum-of-squares:

~~~clojure
(defn sum-of-squares [a b]
  (+ (square a) (square b)))

(defn sum-largest-squares [a b c]
  (cond (and (< a b) (< a c)) (sum-of-squares b c)
        (and (< b a) (< b c)) (sum-of-squares a c)
        (and (< c a) (< c b)) (sum-of-squares a b)))
~~~

Next, we can probably abstract the conditionals themselves, since what we're looking for is the smallest of three elements (min is also provided by clojure):

~~~clojure
(defn sum-largest-squares [a b c]
  (cond (= a (min a b c)) (sum-of-squares b c)
        (= b (min a b c)) (sum-of-squares a c)
        (= c (min a b c)) (sum-of-squares a b)))
~~~

Now, we've got a much more parallel structure here, so we should be able to collapse the conditional, and process the values first.

I'll stop here, but there are a few different ways to get started with the next step - most involve transitioning our three arguments into a list at some point.  I've found it instructive to play around with the different ways of decomposing the problem (including a few side steps along the way to the route I've followed above).  I'm thinking that as I continue with the SICP exercies, I'll try and make a habit of not stopping with the first solution that springs out of my text editor, but to try and explore the structure of the code through refactoring.

Also, while I never managed to figure out refactoring steps that would produce it, I think the most straightforward functional solution (rather than the semi-iterative solution we started with above) winds up being this - it has a certain elegance to it, no?

~~~clojure
(defn sum-largest-squares [a b c]
  (apply + (map square (rest (sort (list a b c))))))
~~~
