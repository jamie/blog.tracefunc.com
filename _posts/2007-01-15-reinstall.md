---
title:  Reinstall
tags:   [linux]
layout: post
---
I'm running Ubuntu 6.10 on my laptop, and a few weeks back the sound decided that it would just stop working. I finally got fed up enough with it to do a reinstall. I thought I'd try out the new beta for [Feisty][], but the installer repeatedly froze on me at 63% on the install, so I gave up and put 6.10 back on. I try to keep tabs on what software I install as extras to ease reinstalls, and tweaked my reinstall scripts from last time to the final forms shown below.

[Feisty]: http://cdimage.ubuntu.com/releases/feisty/herd-2/
After all this, I did manage to get sound up and running, and it even properly mixes now between [Quod Libet][], Gaim, and Firefox/flash. So, total win. Also I got to remove some cruft from my install, and I should be able to get up and running quick when I upgrade to 7.04. No in-place upgrade this time.

This first script takes a custom sources.list (just edited to enable universe/multiverse from all sources, and add a few extras for jedit and some others) and copies it into place, and then installs a new kernel, shell, network manager, and graphics driver. It sets up the networking for WPA (which I use at home). Lastly, it installs a [special driver][] for my video hardware, with an init-script to let my LCD run at native resolution. Fun times I had figuring that one out.

[Quod Libet]: http://www.sacredchao.net/quodlibet
[special driver]: http://perso.orange.fr/apoirier/

    #!/bin/sh

    #sudo cp /etc/apt/sources.list /etc/apt/sources.list.old
    #sudo cp sources.list /etc/apt/sources.list
    #sudo apt-get update

    # Environment
    sudo apt-get install \
      build-essential zsh zsh-doc deborphan \
      linux-image-686 linux-restricted-modules-686 \
      nvidia-glx network-manager network-manager-gnome yakuake

    # Get WPA networking set up
    sudo echo auto lo > /etc/network/interfaces
    sudo echo iface lo inet loopback >> /etc/network/interfaces
    sudo echo ENABLED=0 > /etc/default/wpasupplicant
    sudo /etc/init.d/dbus restart

    # Fix screen res
    cd 855resolution
    make clean
    make
    sudo cp 855resolution /usr/sbin/855resolution
    sudo cp 855res /etc/init.d/855res
    sudo chmod 755 /etc/init.d/855res
    sudo update-rc.d 855res defaults 19
    cd ..

    # Set shell
    echo Enter your password to set zsh as your default shell
    chsh -s /usr/bin/zsh

    echo "\n\n\n\n\n\n"
    echo Please reboot your system now to load the new kernel
    echo and get X running at the correct resolution.
    echo

After rebooting for a real X (and most of my working environment set up), I run the second script, which is essentially just one big batch-install. Version control, database, Java, Ruby, RubyGems (manually), a bunch of a/v codecs for gstreamer, and then a handful of actual applications.

    #!/bin/sh

    # Development
    sudo apt-get install \
      subversion svk darcs mercurial \
      mysql-client mysql-server sqlite3 sqlite3-doc sun-java5-jre \
        sun-java5-plugin ia32-sun-java5-plugin sun-java5-fonts \
        ttf-sazanami-gothic ttf-sazanami-mincho \
      ruby1.8 ruby1.8-dev rdoc1.8 ri1.8 irb1.8 libyaml-ruby \
      libzlib-ruby libmysql-ruby librmagick-ruby libgd-ruby1.8

    # Rubygems
    wget http://rubyforge.org/frs/download.php/5207/rubygems-0.8.11.tgz
    tar xzvf rubygems-0.8.11.tgz
    cd rubygems-0.8.11
    sudo ruby setup.rb
    cd ..
    rm -rf rubygems-0.8.11
    rm rubygems-0.8.11.tgz
    sudo gem update --system
    sudo gem install rails camping nitro

    # Multimedia/Entertainment
    #  lame libdvdcss2
    sudo apt-get install \
      alsa-oss vorbis-tools gstreamer0.10-ffmpeg \
      gstreamer0.10-plugins-bad gstreamer0.10-plugins-bad-multiverse \
      gstreamer0.10-plugins-ugly gstreamer0.10-plugins-ugly-multiverse \
      flashplayer-mozilla unrar unace p7zip \
      msttcorefonts gsfonts-x11 xfonts-intl-european
    sudo fc-cache -f -v # reload font cache

    # Apps
    sudo apt-get install \
      quodlibet quodlibet-plugins quodlibet-ext \
      gnugo quarry wine jedit gnucash gnucash-docs

    echo "\n\n\n\n\n\n"
    echo Please edit /etc/firefox/firefoxrc and change \"none\" to \"aoss\"
    echo

# Comments

Wow, way more complicated than my installation process: http://dev.technomancy.us/phil/wiki/UbuntuInstallation

The most annoying part for me is grabbing all those firefox extensions since it's not easy to script. I've got fiesty herd 3 on my laptop, and it's working fine--better suspend than I got with edgy. But it's always hit-or-miss with these prereleases.

- Phil Hagelberg, at 10:51, Feb 20 2007

