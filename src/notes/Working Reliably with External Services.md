---
title: Working Reliably with External Services
created: 2022-06-23T23:04:30.616Z
modified: 2022-06-23T23:28:03.946Z
---

# Working Reliably with External Services

Possible RailsConf talk proposal, talking about how you can adjust your application to deal with potentially-unreliable external services.

- Dealing with slow requests
  - problem: requests to them timing out can lead to requests to you timing out
  - consider backgrounding the request, and having your app poll itself for task completion
  - If you can work out a reasonable average response time but spikes unpredictably, consider lowering default request timeout closer to that to cut off the slow requests sooner - a request that averages at 0.5-2 sec and peaks up to 20 sec does not need to execute with a 30sec connection timeout.

- Dealing with service outages
  - **Circuit Breakers** can keep your app healthy and responsive - after X errors in a row, internally flag the service as being in an error state, but trickle occasional requests to it to check for recovery. By avoiding external calls while you identify an outage, you can inform users of the issues while keeping your page loads fast.
    - Circuit Breaker can be set up to work for network timeouts, certain error responses, etc.
  - If requests are queued while the service is in an error state, consider **Rate Limiters** around that service to keep from overloading it once it reports as healthy
  - More generally, if you've got background jobs making external requests which automatically requeue after an error, see if your background job system can introduce **Jitter** on retries to spread the load out

- Testing external services
  - Service object + Mock object
  - Test service object via record and replay (VCR), assert against canned responses
  - Test live responses & mock object responses against the same assertions in order to trust that the mock object is providing well-formed payloads


