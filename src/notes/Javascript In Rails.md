---
tags: [code]
title: Javascript In Rails
created: '2020-04-06T19:47:47.984Z'
modified: '2020-12-06T04:57:31.660Z'
---

# Javascript In Rails

Without going full-on with a [[Rails]] API backend, and pure [[React]]/[[VueJS]] frontend, there's still some options to add interactivity and responsiveness to the frontend when moving on from jQuery.

- [[Stimulus JS]] ([web](https://stimulusjs.org/)) is a BaseCamp extraction, doesn't do any rendering, just exists to provide some really straightforward interaction. Plays well with asset pipeline & turbolinks.
  - If you want to supercharge it, check out [StimulusReflex](https://github.com/hopsoft/stimulus_reflex) or [Motion](https://github.com/unabridged/motion) for high-performance reactive components, powered by Stimulus and Websockets.
- [react-rails](https://github.com/reactjs/react-rails) also works with asset pipeline/webpacker, and gives you a straightforward way to render react components from your views. Works best with smaller components.
- [Alpine JS](https://github.com/alpinejs/alpine) directly bills itself as a minimal alternative to Vue/React, can be written inline or extracted to helper methods. Can be readily used as a raw javascript include (via CDN or asset pipeline) to be rails-friendly without bringing in NPM/webpack unnecessarily.

