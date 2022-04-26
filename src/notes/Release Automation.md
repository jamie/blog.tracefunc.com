---
title: Release Automation
created: 2022-04-26T03:36:55.225Z
modified: 2022-04-26T03:44:56.327Z
---

# Release Automation

[Release Please](https://github.com/googleapis/release-please) will monitor master for commits following the [Conventional Commits](https://www.conventionalcommits.org/) format, and build a release PR that updates CHANGELOG.md to list the descriptive changes, and a version file (version.rb for ruby) based on the types of changes: PATCH for fixes, MINOR for features, and MAJOR for breaking changes.

When you're ready to release the new version, just merge the release PR and, if configured, release-please will build and publish the package automatically. Though see also [this workflow](https://github.com/DRBragg/redaction/pull/14/files) for a manual gem release setup.




