---
title:  No More Bundle Exec
tags:   [programming, ruby]
---

[Bundler][] is pretty darn good. Installing all your gems globally sucks. `bundle install --path` does a great job of fixing that but it means you need to `bundle exec` any shell commands you want to run, which again sucks. There are lots of [attempts][] to [fix this][], but they're all fairly convoluted.

[Bundler]: http://gembundler.com/
[attempts]: https://rvm.io/gemsets/basics/
[fix this]: https://github.com/mpapis/rubygems-bundler

I'm a fan of simpler solutions wherever possible. I use [zsh][] as my shell, which has a [handler][] you can hook into if the command you're trying to run is not found. It's a simple matter to hook that into a custom shell script from your `~/.zshrc`:

[zsh]: http://www.zsh.org/
[handler]: http://zsh.sourceforge.net/Doc/Release/Command-Execution.html

    function command_not_found_handler() {
        ~/bin/command-not-found $*
    }

I know [bash][] supports this kind of handler ([Ubuntu][] uses it to provide command helpers for not-yet-installed programs) but I don't know the exact details. Alas, my favorite shell ever, [fish][], only provides the executable to its corresponding helper, so while it can suggest an alternate command, it can't auto-correct it.

[bash]: http://www.gnu.org/software/bash/manual/bashref.html
[Ubuntu]: http://www.ubuntu.com/
[fish]: http://ridiculousfish.com/shell/

My script happens to be in [Ruby][], but it could just as easily be a standard shell script as all I'm doing is some file existence tests:

[Ruby]: http://www.ruby-lang.org/en/

    #!/usr/bin/env ruby

    # ARGV is the entire command we wanted to run, but we
    # really only care about the actual executable for fallbacks
    command = ARGV.first

    def run(cmd)
      $stderr.puts "Running #{cmd.inspect} instead"
      system(cmd)
    end

    case
    when File.exist?("./.bundle/config") && File.exist?("./bin/#{command}")
      run("bundle exec #{ARGV.join(' ')}")

    else
      exit 127
    end

Now, as long as you're being sure to `bundle install --binstubs` it should Just Work. And because it only functions if you're in a directory that's been bundled, you don't run into the security risks that you would by trying to get ./bin added to your `$PATH` directly.

Lastly, the `case` statement instead of an `if` is a bit redundant in the simple case above, I've actually got a few more filters for things like [isolate][] and [git][] - don't forget to quote anything that might need space literals:

[isolate]: https://github.com/jbarnette/isolate
[git]: http://git-scm.com/

~~~ruby
# Paste git repo url to clone it
when command =~ /^git(@|:\/\/).*\.git$/
  run("git clone #{command.inspect}")

# paste compressed url to download+extract it
when command =~ /^(?:ftp|https?):\/\/.+\.t(?:ar\.)?gz$/
  run("curl #{command.inspect} | tar xzv")

when File.exist?("./tmp/isolate/ruby-1.8/bin/#{command}")
  run("rake isolate:sh['#{ARGV.join(' ')}']")
~~~
