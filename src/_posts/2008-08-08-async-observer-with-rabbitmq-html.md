---
title: Async-Observer with RabbitMQ
tags:  [ruby, rails, merb]
---

**Update:** This code is stale, I've extracted a gem of it and posted on [github](http://github.com/jamie/async-observer-amqp).

[Async-observer][] is great.  Fast, easy to use API, and it Just Works.  The downside is that the backend, Beanstalkd, doesn't support persistent messages in case the server crashes.  I hear it's on the roadmap, though.

However, there's another messaging backend, [RabbitMQ][], that seems just as easy to get set up, and does support persistent messages.  So, how to get these two bits of tech working together?  Well, if you're hosting your app on [Thin][] (or another app server that runs in [EventMachine][]), it's pretty straightforward.

First, install the [amqp][] ruby library to connect to rabbit, and then add a tiny bit of setup.

[Async-observer]: http://github.com/kr/async-observer/tree
[RabbitMQ]: http://www.rabbitmq.com/
[Thin]: http://code.macournoyer.com/thin/
[EventMachine]: http://rubyeventmachine.com/
[amqp]: http://github.com/tmm1/amqp

In config/environment.rb:

```ruby
require 'mq'
class BeanstalkPoolImpersonator
  def initialize(opts={})
    @opts = opts
  end

  def connect
    connection = AMQP.connect(@opts)
    @channel = channel = MQ.new(connection)
  end

  def use(queue)
    @queue = MQ::Queue.new(@channel, queue)
  end

  def yput(obj, pri, delay, ttr)
    p [obj, pri, delay, ttr]
    @queue.publish(YAML.dump(obj))
  end

  def last_server
    :last_server_stub
  end

  def subscribe(*args, &blk)
    @queue.subscribe(*args, &blk)
  end
end
```

Then, instead of connecting via `Beanstalk::Pool.new`, do this:

```ruby
AsyncObserver::Queue.queue = BeanstalkPoolImpersonator.new()
```

You can pass an options hash to the `new` call, providing user, pass, vhost, host, or port as necessary.

Then, in your workers, load up the async_observer worker class, and extend like so:

```ruby
class RabbitWorker < AsyncObserver::Worker
  def run()
    EM.run do
      AsyncObserver::Queue.queue.connect
      AsyncObserver::Queue.queue.use('1.0')
      AsyncObserver::Queue.queue.subscribe do |headers, msg|
        job = OpenStruct.new(:ybody => YAML.load(msg), :body => msg, :stats => [])
        job.id = headers.properties[:delivery_tag]
        safe_dispatch(job)
      end
    end
  end
end
```

Create the new worker the same way you would for the AO::Worker, and you're set:

```ruby
    RabbitWorker.new(binding).run()
```

Note: I'm maintaining a [merb port][] of async-observer on github.

[merb port]: https://github.com/jamie/async-observer

Note 2: This worker is somewhat fragile, if the RabbitMQ server goes down it will just hang forever waiting for more jobs.  I'll need to figure out a solution to that before we move this into production (and I wrap it up in a gem), but I thought I'd get this out and about now.
