#/bin/sh

# dependencies for Ubuntu 18.04 chroot

packages="
fuse
git
wget
build-essential
autoconf
automake
autotools-dev
autopoint
gettext
intltool
libtool
libgl1-mesa-dev
libx11-dev
libice-dev
libfreetype6-dev
libfontconfig1-dev
libass-dev
libicu-dev
libboost-chrono-dev
libboost-filesystem-dev
libboost-locale-dev
libboost-regex-dev
libboost-system-dev
libboost-thread-dev
libasound2-dev
libopenal-dev
libpulse-dev
libffms2-dev
libfftw3-dev
libhunspell-dev
libuchardet-dev
libwxbase3.0-dev
libwxgtk3.0-dev
wx3.0-headers"

apt update && apt upgrade && apt install $packages
