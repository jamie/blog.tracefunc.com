title:  Installing Wifi without Internet
tags:   [linux]

I picked up a [new machine][] this week to turn into a home media server, and had a small hoop to jump through with the Broadcom [wifi card][] I picked up. Problem being, office and all my monitors were upstairs, wifi was downstairs, and it's difficult to install new drivers without net access.

[new machine]: http://www.ncix.com/products/?sku=33671
[wifi card]: http://www.ncix.com/products/?sku=24255

But, [Linux Mint][] popped up a "new hardware" dialog, saying it wanted to use b43-fwripper to set up the drivers. Good news, it gave me the url it failed to download from. Manually download [the deb][], open it up on my other machine using Archive Manager (rather than GDebi), and navigate through to the postinstall script, at data.tar.gz/./usr/share/b43-fwcutter/, and I find a reference to two [other][] [files][].

[Linux Mint]: http://www.linuxmint.com
[the deb]: http://archive.ubuntu.com/ubuntu/pool/main/b/b43-fwcutter/b43-fwcutter_011-5_i386.deb
[other]: http://downloads.openwrt.org/sources/wl_apsta-3.130.20.0.o
[files]: http://mirror2.openwrt.org/sources/broadcom-wl-4.150.10.5.tar.bz2

After downloading those, copy all three files to the new box. Copy the .deb to /var/cache/apt/archives, and then apt-get install b43-fwripper. Ignore the failure, then go to the dir with the other two files, and manually run the 3 useful lines from the install script (don't forget to add sudo to the last one):

    b43-fwcutter -w /lib/firmware wl_apsta-3.130.20.0.o
    tar xfvj broadcom-wl-4.150.10.5.tar.bz2
    b43-fwcutter --unsupported -w /lib/firmware broadcom-wl-4.150.10.5/driver/wl_apsta_mimo.o

Reboot, and voila - local wifi networks show up in the tray applet. I presume these steps will work for an Ubuntu install as well, since Mint is based on Ubuntu, but I haven't tried it as yet - in fact, the required .deb is on the Ubuntu 9.04 livecd. I also don't know if these files will work for other Broadcom wireless adapters, but if your modern linux system can do a hardware detect and tell you what driver it's trying to pull down, that should be a good starting point.
