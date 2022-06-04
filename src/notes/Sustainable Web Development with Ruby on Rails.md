---
title: Sustainable Web Development with Ruby on Rails
created: 2022-06-02T17:43:42.611Z
modified: 2022-06-03T21:49:01.764Z
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

## ...

...

