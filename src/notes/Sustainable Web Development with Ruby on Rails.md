---
title: Sustainable Web Development with Ruby on Rails
created: 2022-06-02T17:43:42.611Z
modified: 2022-06-23T23:00:23.538Z
---

# Sustainable Web Development with Ruby on Rails

Notes from [David Copeland's book on Rails app development](https://sustainable-rails.com/).

I've been doing Rails >15 years, and it's totally worth the $50 in general advice from a number of locations.

## Ch.2 Rails Application Architecture

A reminder that you can treat the application as somewhat of a layer cake:

- Boundaries accept input and arrange output: controllers, and mailers, but also jobs, rake tasks (to kick off scheduled jobs), and connections to external services (David calls out ActiveStorage, but writing or importing any adapter class to talk externally counts)
- Views present information, be it ERB, JSON, or XML, and includes other presentation details like CSS/JS for web pages. This layer is fairly tightly constrained to have calls from controllers and mailers, but possibly also has some overlap with building payloads for external services
- Models include but are not limited to DB-backed ActiveRecord - a lot of people are happy without a dedicated "service layer" for business logic and just put a lot of plain ruby objects inside app/models.
- And finally everything else: configuration, dependencies, tests, seed data...

Finally, talking about pros and cons: there's a huge number of decisions to be made when designing an application from scratch, and Rails making 95% of those right out of the gate, and making them work _very well_ together (see eg. form helpers tight integration with ActiveRecord models) is a huge productivity boon not only starting an app but ongoing. The major downsides are a strong focus on the "database-backed web application", so you can't really use Rails effectively for a desktop app, and that it doesn't provide strong guidance for business logic (which is discussed further in many other chapters).

## Ch.4 Start Your App Off Right

Walks through some choices setting up a new rails app, with plenty of actual code examples. Suggests:

- Use Unix ENV to configure everything - get rid of database.yml (just use `DATABASE_URL`) and credentials files (provide `SECRET_KEY_BASE` and you'll be fine without). Dotenv with `.env.development` and `.env.test` gets the job done locally, and production you provide separately (Heroku/Render just edit them in the UI, kubernetes or something you'd provide in your orchestration configs).
- `bin/setup` replacing the default with a custom script (and documentation, including a help subcommand) to get a functional dev environment from scratch given you have required services (like Postgres) running. NB: this should be idempotent, so coming back to an app you haven't worked on in a while is the same process as picking it up for the first time.
- `bin/run` starts the app - in his example explicitly providing `--binding=0.0.0.0` to work inside docker
- `bin/ci` runs tests and quality checks in a similar fashion to CI

There's two benefits to setting an app up like this. Firstly, relying on ENV for configuration and a few scripts in `bin` are universal - if you wind up in a polyglot environment you can stick to that convention for easier onboarding. Secondly, _all_ these things act as executable documentation that rarely gets out of date - `setup` explicitly calls out how you pull in dependencies and bootstrap config for a new machine, `ci` calls out all your test code (which might be run piecemeal on an actual CI server for parallelism), and `run` abstracts away being tied to just Rails so if you need say an external job process it can spin that up too.

## Ch.5 Business Logic (Does Not Go in Active Records)

Makes a good argument around reach and churn - business logic is more exposed to churn and changing behaviour over time, compared to core data models (like User, if your app requires folks to log in). If you leave ActiveRecord objects to just core data responsibilities (validation, helpers for form builders, associations, etc) and push business logic up to separate classes then those classes where changes would have the broadest impact will change less frequently. This means individual changes become easier to reason about as they have a smaller blast radius.

A similar argument can be made around Controllers - keeping your controller actions focused on params, success checks, and control flow (rendering/redirects) by pushing batches of logic down to a service layer keeps your controllers simpler, and lets you unit test your business logic at that service layer which is easier and faster to run.

For my own perspective, while ActiveRecord doesn't do "functional" style programming well, you can at least keep to idempotent instead. If an AR class has validations (which can be repeated fine), data wrappers/formatters, and finders, you can treat it as being reasonably stable 

## Ch.6-12 Routes, HTML, Helpers, CSS, Javascript, View Testing

The table of contents here does a great job summarizing the content - a lot of it skews to "sticking to Rails defaults, and working to keep things consistent is a great way to make sure any engineer can find their way around the codebase". Some specific notes:

- Expose one instance variable per action -- my chief concern here is that if you've got a complex page that iterates a few has_many associations (profile page, with most recent posts, comments, likes) it can be a challenge to set up all the eager loading correctly chained off the primary object load. However, for modern Rails that does sound like a _great_ place to defer loads with Turbo Frames if you're serving HTML. Still awkward if you're building an API payload.

- Only put helpers in `ApplicationHelper` -- it winds up all in a global namespace anyway so splitting helpers per controller is lying to yourself. 

- Build a component library with previews/demos to document your design system -- I'm still not sure if it's worthwhile to go all-in on ViewComponent, but just making note that [doing this is supported natively there](https://viewcomponent.org/guide/previews.html).

- Javascript is notorious for high churn in dependencies, be deliberate about what you take on.

## Ch.13-17 Models, Database, and Business Logic

Chapters 13-16 describe a delegation of concerns that doesn't match my prior experience with Rails, and chapter 17 ties it all together with an end-to-end example demonstrating how the full stack fits together:

- The controller acts as glue: turns params into a model, creates a service object and calls an operation on it, then checks that response to determine what to do next. This is tested with a system test for flow, both on success and failure. Assertions are purposefully mininal and focused on the core requirements of flow - on success, do we see content on the next screen that proves the success of the action? on failure, do we see content around expected error messages.
- The controller presents one instance variable (it's resourceful, so the resource we're working with) except in cases of supporting "generic" data like options for a dropdown, so the view can be tested simply, and independently.
- Business logic objects get their own home in app/services, and act as a "seam" where they present a straightforward and small API, allowing for independent refactoring on either side. They can be reused and moved around in the controller layer, and independently grown as business requirements change and accrete. These just use regular tests. Aside: it's very explicitly called out that service objects should have a clear method name, ie. `WidgetCreator#create_widget` as it makes it much easier to navigate the codebase (compared to alternatives where every service object has `.call`).
- Models models consist of validations, non-business-related finder scopes, and simple derived data readers (eg, `def name; "#{firstname} #{lastname}"; end`). `ActiveModel` can be included in plain ruby classes to provide domain objects usable by restful resources without requiring them to be backed by the database. Standard testing, same as business objects.
- The database is leveraged whenever plausable for data integrity - column sizing, unique constraints, foreign key constraints...

Overall this reminds me somewhat of the [dry-rb](https://dry-rb.org/) family of gems in pushing responsibilities away from controller/model, but there's a very pragmatic approach of using Rails defaults where they are the most powerful/valuable. ActiveRecord validations are more business logic than anything, and they're only written in response to behaviour defined in the business tests, but using them rather than say dry-validation (or just one-off validation logic in service objects) means they hang around with the model, can be asserted against in response objects, work well with form helpers for error messaging, etc etc.

## Ch.18-20 Controllers, Jobs, Other Boundary Classes

If business logic and the data model are the core of the application, section II wraps up with a discussion on the various edges of the system.


...
