title:  Embedding Gems in Merb
tags:   [programming, merb]

Daniel Manges did up instructions on [storing explicit versions of gems in your rails app](http://www.dcmanges.com/blog/rails-first-class-vendor-gems).  If instead you're using merb, you probably want to do that too, as it makes for much easier deploys.

Thankfully, it's much less pain in merb:

    gem install async-observer -i gems

The `-i` option tells rubygems to install the gems to that directory, and when you require the gem from inside merb, it will look in the local gems directory first, and find yours.

Optionally, you can skip generating docs by adding `--no-rdoc --no-ri` to the line, and depending on what you're installing, you may want to `--ignore-dependencies` as well.

If the gem in question builds a binary extension, you may be out of luck if you try to deploy it to a different architecture.

The only problem I've found so far is that `gem cleanup` won't accept a directory to clean, so you'll need to manually remove individual gems when you upgrade:

    gem uninstall -i async-observer


