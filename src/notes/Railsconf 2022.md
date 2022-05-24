---
title: Railsconf 2022
created: 2022-05-18T22:09:26.754Z
modified: 2022-05-24T16:27:12.848Z
---

# Railsconf 2022

Talk notes & Reminders. Videos available next month for RailsConf Remote, and then a few months after on youtube.

## Opening Keynote

Xavier Noria kicked off with a technical talk around Rails autoloading and Zeitwerk, the new-rails-6/default-rails7 autoloader for rails.

## Breaking up with the Bundle

Joel from Github talking about the state of their CSS bundle, they've been finding it was a pain point, suffering through visual regressions because of essentially selector bleed.

The Github solution is ViewComponents & [Primer](https://primer.style/) component library, which is a ruby-focused solution to keep styles strongly scoped while staying maintainable.

Over the past few years they haven't been aggressively working at eliminating custom CSS, but they've done a good job plateauing it and keeping the problem from getting worse.

## React-ing to Hotwire

[slides](https://github.com/esmale/react-ing-to-hotwire)

David talked about his experience going from a team of 3x Rails + 2x JS devs on a "typical" Rails+React app, after losing 3 employees including both JS devs, and discovering that React isn't _just_ react, but also a web of other dependencies.

To reduce maintenance burden, they started replacing React with Turbo+Stimulus to keep "rails-standard" and found it a good tradeoff.

## (Workshop) Upgrading Rails: The Dual-Boot Way

[Workshop notes](https://www.fastruby.io/rc2022)

Worked through an example open-source application running Rails 5.2, setting up the next-rails gem to check compatibility, and then dual boot the app (and specs) with conditional config/logic changes.

## End of the day keynote

Aaron started with a bit of a digression into JIT compilers, talked about one in Ruby, and how he wrote some tests that run on both x86 and ARM processors without conditionals (spoilers: ASM hijinx).

He then switched over to ....

## Keynote

Eileen gave a summary of the Rails Governance Model, and the breakdown of the various teams (Core, Security, Issues, etc) and responsibilities, and talked about her journey to being on the Rails Core team.

She then made a plea to attendees: contribute back (and/or encourage your company to contribute back). Getting caught up to date on dependencies means you're not suffering bugs that have already been fixed, and at that point you can take any local monkeypatches/workarounds and get them upstream to solve problems for others -- this also reduces your maintenance burden on local patches every upgrade.

## Rails performance guidebook: from 0 to 1B requests/day

Cristian talked about various topics on rails performance, coming from his work at Zendesk. Highlights:

- When you have a cache or something for denormalized data, after doing an update you can pre-populate the cache with the modified data (possibly async) in preparation for reads
- Have large amounts of old data with infrequent read usage? Consider cold storage. Zendesk's "ticket" model is 86% in cold storage in S3, keeping their primary table (still very large) manageable.

## Unboxing Rails 7: what's new in the latest major version

[slides](https://speakerdeck.com/claudiob/unboxing-rails-7)

Claudio covers some of the less-high-profile changes in Rails 7

## Test Double Lab

Tyler at Test Double helped me out with root-cause analysis on conflict between Cucumber and a backported Turbo into a Rails 5.2 codebase. Cool guy.

Also pointed me at [https://danger.systems/ruby/](Danger), which runs on CI and can flag violations of conventions (which you can custom design with ruby code).

## Bringing your Rails Monolith along as the business grows

Sponsor: Ontra

Carrick talks about his experience at Ontra, dealing with a growing Rails monolith (and React frontend).

They put a companywide focus on keeping good code quality, and empowering teams to work in upgrades as they hit them. But pragmatically, they only upgrade code when they touch it rather than trying for a big-bang migrate-the-world approach.

They also called out RSpec as being a great tool, but using it for all their frontend tests is slow and they're moving to Ember Tests instead (API tests ofc still rspec).

## Ooops! You named it wrong!

Ian and Melissa gave an entertaining tag-team talk covering cases of bad names they've seen, and approaches they've taken to rename things to bring more clarity to their codebases.

Biggest takeaway is the larger the blast radius the harder change is (worst case: you've got multiple collaborating apps with common terminology), but it can still be done with care and coordination if it's a valuable enough change.

Regarding data model changes (column or even table renames) the multi-deploy approach is still best:

- Create new column/table
- Start writing to both locations
- Backfill data from old to new location
- Adjust reads to new location
- Stop writes (and get ActiveRecord to ignore the column)
- Drop old column/table

Also, [Strong Migrations](https://github.com/ankane/strong_migrations) is invaluable in reminding you to play it safe.

## Keynote

Crystal talked about non-technical empowerment topics. Brought up the Drama Triangle of accuser/rescuer/victim roles when problems come up, and how it's better to empower people by changing the script to challenger/coach/creator. (google for those terms leads to a few articles, I haven't read any though)

## Laying the culture and technical foundation for Big Rails

[slide deck](https://speakerdeck.com/alexevanczuk/100-railsconf-laying-the-cultural-and-technical-foundation-for-big-rails?slide=8)

[companion blog post](https://engineering.gusto.com/laying-the-cultural-and-technical-foundation-for-big-rails/)

Alex from Gusto talked about the changes they've been making to their Rails monolith to help with maintainability and development velocity. Callouts were packwerk to split out code in packages, setting up package ownership, and gradually adopting strict dependency management.

## Your Service Layer Needn't be Fancy, It Just Needs to Exist

3 micro talks from engineers at Chime:

David talked about their proactive security & engineering culture w/ Monocle. Automation can be proactive, saves many hours of eng time. Chime built Monocle in-house as a rails app, which does a nightly analysis of each of their many services, doing things like run brakeman/bundler audit/docker image checks, and then presents a breakdown browseable from the app (& a status badge on the app's readme).

Brian talked about secure & observable software w/ ActiveSupport. ActiveSupport::Notifications is built-in instrumentation, separates concerns of instrumentation collection, logging, and business logic: instrument to collect, monotonic_subscribe for reporting -- see also ActiveSupport::LogSubscriber and ParameterFilter.

Chris talked about Onboarding Ruby devs.

## Start your Ruby Podcast Today

Chris, Andrew, and Jason talked about things to keep in mind when starting your own podcast - TLDR; start small, be consistent, and layer on tech solutions only when you need it. And also have fun.

## Your test suite is making too many database calls!

[slides](https://speakerdeck.com/joelq/your-test-suite-is-making-too-many-database-calls)

Joël talks about slow tests (and plugs Aji's TDD Treasure Map talk from the previous timeslot). Focus is on creating too much test data.

- Test Code: Shared/common test setup can create redundant objects not necessary for tests. (VPY note: see the complexity in many of our specs that create object chains user/account/sender/customer/invoices...) Especially calls out cases where tests in a file use diverse subsets of data but all wind up instantiating the same amount of data. Also, `update` in setup data is a code smell for underlying data problems.
  - Fixes: find slow specs, `tail -f test.log` and run single spec to check queries.
- Support code: Factories with chained objects are _expensive_. Best practice: minimal base factory, and use traits to explicitly opt in (`create(:user, :with_account)`).
  - Fixes: `ActiveSupport::Notifications.subscribe("factory_bot.run_factory")` and log invocations, times. Also TestProf gem can report. Rails console in `test` env, log level `debug`, and create a factory to see list of inserts.
- Application code: Callbacks create more data (and/or trigger follow-on updates).
  - Fixes: Much harder than other fixes, but pain in tests can also be a symptom of pain for other devs in app code.

Case study: AS::Notifications subscribe to log all factories, plot frequency by time, and found one taking 4sec but called infrequently. Then dug in to find out what it was doing (spoilers: weird association setup in the factory was wasteful).

## Learn it, Do it, Teach it: How to Unstick Our Middle Devs

Chelsea talking about how we can encourage junior/midlevel devs on their path to seniors.

- Learn it: keep a habit of learning new things
- Do it: you don't learn by following rules, you learn by doing, and making mistakes
- Teach it: to teach is to learn twice over - forcing ideas into words crystallizes thinking

Make an environment that allows people at all skill levels (especially junior) to present / cross-train on topics, which helps solidify the speaker's knowledge way better than just passively taking in a lesson.

Skill trifecta to accelerate learning - Standup / Retro / Pairing

Mentoring can be a huge benefit on both sides - even at smaller differences in career path (as low as 3mo-6mo) there's a benefit to the mentor.

Takeaways:
- When we teach we will learn,
- Assess through explanation
- Mentorship at all levels

## End of the day Keynote

Viadehi closed out the conference, giving a great reminder of Burnout being an actual thing, and encouraging everyone to make sure to take time to listen to their bodies, and be aware of how much overwork absolutely sucks.

## Slides from other sessions I didn't attend

- [Puny to Powerful PostgresSQL Rails Apps](https://andyatkinson.com/pg-puny-powerful)
- [Open the gate a little: strategies to protect and share data](https://speakerdeck.com/ferperales/open-the-gate-a-little-strategies-to-protect-and-share-data) -- [sample repo](https://github.com/FerPerales/anon_app)

