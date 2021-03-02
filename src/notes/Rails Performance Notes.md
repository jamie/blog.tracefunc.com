---
title: Rails Performance Notes
created: '2021-01-31T06:00:00.361Z'
modified: '2021-01-31T06:07:07.436Z'
---

# Rails Performance Notes

> Notes reading [Complete Guide to Rails Performance](https://www.railsspeed.com/) by Nate Berkopec

### Cheat Sheet

From "The Easy Mode Stack" - Nate's defaults until you outgrow them or acquire special needs.

- CDN: Cloudflare
- JS: HTML-over-the-wire
- Webserver: Nginx
- App server: Puma
- Host: Heroku
- Webfonts: Google Fonts
- Web Framework: Rails
- HTTP Library: Typhoeus
- Database: Postgres
- DB Vendor: Whatever's closest to you
- Cache Backend: Redis
- Background Jobs: Sidekiq
- Performance Monitoring: New Relic
- Performance Testing: siege, ab, wrk
- Realtime Framework: message_bus (ActionCable still difficult to scale)
- User Auth: has_secure_password (builtin! Devise not necessary, but use it if you need OAuth)
- Ruby: MRI (CRuby)
- Views: erb, or Haml via hamlit


