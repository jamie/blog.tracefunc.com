I like having all my stuff in one spot. So, installing all my gems
inside the homebrew directory sounds like it makes sense.

set -Ux GEM_HOME (brew --prefix)/Cellar/Gems/1.8
set -Ux GEM_PATH (brew --prefix)/Cellar/Gems/1.8:/System/Library/Frameworks/Ruby.framework/Versions/Current/usr/lib/ruby/gems/1.8/gems

http://wiki.github.com/mxcl/homebrew/gems-eggs-and-perl-modules

And don't forget the brewbygems gem.
