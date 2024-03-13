---
title: Microservice Mistakes
created: '2023-09-19T18:25:09.842Z'
modified: '2023-09-19T21:27:24.287Z'
---

# Microservice Mistakes

via [J. Tower at NDC London 2023](https://www.youtube.com/watch?v=p2GlRToY5HI)

Ideal microservices architecture is fronted with an API Gateway, and comprised of multiple fully-independent applications (with their own DB) that communicate via an event bus (avoiding inter-application requests).

Does call out that a "Modular Monolith" can also gain many benefits of microservices with the monolith divided interally into clear modules, but stil deployed as a single unit.

J's top 10 microservice mistakes:

1. **Assuming Microservices are Always Better**
  There's an inherent tradeoff between High-Availability (microservices) and Immediate Consistency (monoliths).
2. **Shared Data Store or Models**
  Multiple applications talking to one database with shared tables, schema changes will lead to a _world_ of pain. Similarly if you've got "common" data model objects.
3. **Microservices that are Too Big**
  See _Domain-Driven Design_ by Eric Evans. J's simple rule: smallest possible microservices without chatty communication between services. "If a services needs to send events for everything it does, it might be too chatty."
4. **Microservices that are Too Small**
  Also don't go to far the other way.
5. **Starting from Scratch**
  Migrating monolith -> microservices has advantages in existing code and relationships, people who know the system & domain, a system that works, and a baseline to compare with.
  Migration approaches: "Big bang" (only works for small projects), "Evolutionary" (extract service, improve performance, repeat), "Strangler Fig" (Facade in front, slowly migrate code underneath).
6. **Coupling Through Cross-Cutting Concerns**
  Eg. distributed logging is hard.
7. **Use of Synchronous Communication**
  Propagates slowness/outages across services.
8. **Breaking Changes to Event Contracts**
  Be strict about event changes: New fields are optional only with defaults, unrecognized fields are ignored but forwarded, consumers of optional fields use defaults when missing, and if any of the above can't be satisfied you need a new event type.
9. **Not Automating Build and Release**
  (This is CI/CD/Devops.) Manual build/release is time consuming and prone to human error.
10. **Unencapsulated Services**
  Small, stable APIs help enable you to make changes to your implementation without impacting API consumers.
11. **Mismatched Teams** (bonus!)
  Conway's Law: Whatever your team builds is going to look like the org chart, one team mob programming microservices will likely lean toward monoliths.



