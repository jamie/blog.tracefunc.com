---
title: Rails Authentication
created: 2020-08-25T23:57:24.022Z
modified: 2020-08-26T02:08:47.179Z
---

# Rails Authentication

- [Devise](https://github.com/heartcombo/devise) is the gorilla, customizable and full-featured, but complex
- [Clearance](https://github.com/thoughtbot/clearance) is more opinionated, but doesn't out-of-the-box support complex workflows like requiring email confirmation before login
- [Authlogic](https://github.com/binarylogic/authlogic) is more at the simple end, providing just the core hooks for User model and login/logout handling, but you need to provide the controller/view logic.
