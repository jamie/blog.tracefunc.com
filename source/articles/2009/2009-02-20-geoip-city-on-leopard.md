---
title:  geoip_city on Leopard
tags:   [osx]
---

I've been trying to figure out a minimal way of getting the geoip_city gem installed on my mac, and having [seen][] a few [ideas][] on google, I'm gonna consolidate into a minimal solution.  I originally wanted to work with the macports version of libgeoip, but had absolutely no luck with that, so here's something a bit more manual:

[seen]: http://snippets.aktagon.com/snippets/179-Geolocation-with-MaxMind-s-GeoIP-and-the-geoip-city-RubyGem
[ideas]: http://www.rubynarails.com/22/8/2008/how-to-install-geoip_city-gem-on-leopard

    # we need to be root for the ARCHFLAGS later to stick
    sudo su
  
    mkdir -p /usr/local/src
    cd /usr/local/src
  
    # Download and install latest geoip
    curl -O http://geolite.maxmind.com/download/geoip/api/c/GeoIP-1.4.5.tar.gz
    tar -xzf GeoIP-1.4.5.tar.gz
    cd GeoIP-1.4.5
    ./configure
    make
    make check
    make install
  
    # install the gem
    export ARCHFLAGS='-arch i386'
    gem install geoip_city

The main sticking point for me was that setting ARCHFLAGS doesn't continue through to a `sudo gem install`, so we need to do the whole thing as root.

But, now that we've done that, we can grab the GeoLiteCity database and point our app at it:

    curl -O http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz
    gunzip GeoLiteCity.dat.gz
