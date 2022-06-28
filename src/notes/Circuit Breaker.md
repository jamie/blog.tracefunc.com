---
title: Circuit Breaker
created: 2022-06-23T23:03:19.540Z
modified: 2022-06-23T23:03:41.635Z
---

# Circuit Breaker

```ruby
# Logic based on https://martinfowler.com/bliki/CircuitBreaker.html
class CircuitBreaker < ApplicationRecord
  ERROR_THRESHOLD = 5
  RESET_TIMEOUT = 5.minutes

  # name, error_count, last_error_at
  def state
    if error_count < ERROR_THRESHOLD
      :ok
    elsif last_error_at < RESET_TIMEOUT.ago
      :recoverable
    else
      :error
    end
  end

  def call(primary, alternate, recoverable_errors = [StandardError])
    if state == :error
      alternate.call
    else # :ok, :recoverable
      begin
        primary.call.tap { record_success }
      rescue *recoverable_errors => exception
        Sentry.capture_exception(exception)
        record_failure
        alternate.call
      end
    end
  end

  private

  def record_success
    update(error_count: 0) if error_count > 0
  end

  def record_failure
    update(error_count: error_count + 1, last_error_at: Time.current)
  end
end
```


