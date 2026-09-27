Cloudflare has a few hiccups to get a clean build of Bridgetown going. Cloudflare serves the site as a Worker with static assets, you don't need Cloudflare Pages or specific Worker code.
## Project config

- Node version in `.node-version` (for example, `24.18.0`).
- Ruby version in `.ruby-version` - for cloudflare, this needs to be a bare version number, not rbenv `ruby@4.0.0` style.
- See https://developers.cloudflare.com/workers/ci-cd/builds/build-image/ for specific supported supported versions that are available without eg. compiling ruby from scratch each deploy.
	- Sep 2026, docs say ruby@3.4.4 is in the build image, but it's still installing from scratch each deploy.
- Aside: if you've got plugins that read files from disk, they need an explicit encoding as the Cloudflare build image defaults to US-ASCII. `File.read(path, encoding: "utf-8")` or similar.
  Run locally as `LANG=C LC_ALL=C BRIDGETOWN_ENV=production bin/bridgetown build` to surface those errors.
-  If you use npm 11, approve the install scripts that the build needs (for example, `npm approve-scripts esbuild`). Commit the change to `package.json`.
- Add `wrangler.jsonc` to the root of the repository:
  ```jsonc
  {
    // This name must be the same as the Worker name in the dashboard.
    "name": "my-site",
    "compatibility_date": "2026-09-26",
    "assets": {
      "directory": "./output",
      "not_found_handling": "404-page"
    },
    "routes": [
      { "pattern": "sub.example.com", "custom_domain": true }
    ]
  }
  ```
-  Set `directory` to the build output folder., make sure that the output folder has a `404.html` file, and ignore the working folder `.wrangler` in `.gitignore`.
- Configuration check: `npx wrangler deploy --dry-run`

## Cloudflare setup

- Go to **Workers & Pages** and connect the Git repository.
- Make sure that the Worker name is the same as `name` in `wrangler.jsonc`.
- Build command: `bundle install && npm install && bundle exec bridgetown deploy`
- Deploy command `npx wrangler deploy`
- Add a Variable `BRIDGETOWN_ENV=production`
- Push to the main branch. Make sure that the build and the deploy are successful.
	- The `routes` block in `wrangler.jsonc` will trigger creating a subdomain record, if you already have one defined (ie, you're migrating hosting to Cloudflare) the deploy will fail - you'll need to delete the existing CNAME before running a build.

## Ruby Specifics

There's a build image at https://developers.cloudflare.com/workers/ci-cd/builds/build-image/ and it's _pretty_ out of date. And also documented wrong. As of Sep 2026, that means:
- ruby 3.4.7 (October last year)
- bundler 2.6.7 (April last year)

Including `.ruby-version` in your project, even if it's pointing at 3.4.4, will result in a fresh ruby install which takes about 5 minutes. Very annoying, doesn't look like 