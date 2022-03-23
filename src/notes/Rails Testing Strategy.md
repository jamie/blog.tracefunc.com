---
title: Rails Testing Strategy
created: 2021-10-08T20:12:36.279Z
modified: 2021-10-08T20:19:31.105Z
---

# Rails Testing Strategy

- In an [interview](https://www.maintainable.fm/episodes/dhh-celebrating-legacy-software-and-the-story-of-how-humans-cant-estimate) DHH goes into his workflow:
  - Fixtures
  - Minitest (Test/Unit)
  - Lots of Controller tests
  - Unit tests when doing something complicated
  - System tests when needed for testing flow
  - Runs Basecamp 3 test suite in ~ 2 mins

- Jason Swett (the Rails Testing guy) has [a book](https://www.codewithjason.com/complete-guide-to-rails-testing/)
  - Rspec
  - Model specs: always
  - System specs: always
  - Request: rarely (usually redundant to system specs)
  - Helper: rarely
  - View/Routing/Mailer/Job: never

