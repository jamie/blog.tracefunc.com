title:      Announcing Webbylog
tags:       []

I've decided to formalize my blog-posting process, so I've wrapped up a few helper rake tasks for use with [Webby][].

[Webby]: http://webby.rubyforge.org/

Basic workflow is pretty simple.  `webby blog:new[Post Title]` will create a new draft post, which is then edited.  `webby blog:drafts` will list the current drafts by title, and `webby blog:publish[id]` will timestamp and publish the draft.  Then a regular `webby deploy` will push it up for the world to see.

I've also got announcements to twitter built in, and plan to add some github pages integration shortly, so that it can self advertise.

In the mean time, you can check out what I've got so far [on github][].

[on github]: http://github.com/jamie/webbylog/
