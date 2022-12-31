#!/bin/sh
set -e
set -x

JOBS=4

PFX="$PWD/usr"
APPDIR="$PWD/aegisub-wangqr/aegisub.appdir"
DOCDIR="$APPDIR/usr/share/doc"
export PATH="$PFX/bin:$PATH"
export LD_LIBRARY_PATH="$PFX/lib:$LD_LIBRARY_PATH"
export PKG_CONFIG_PATH="$PFX/lib/pkgconfig:$PFX/share/pkgconfig:$PKG_CONFIG_PATH"

# libass
cd libass
./autogen.sh
./configure --prefix="$PFX" --disable-static --enable-shared
make -j$JOBS
make install
mkdir -p "$DOCDIR/libass"
cp COPYING MAINTAINERS "$DOCDIR/libass"

# ffmpeg
cd ../FFmpeg
./configure --prefix="$PFX" \
  --disable-programs \
  --disable-doc \
  --enable-gpl \
  --enable-version3 \
  --disable-static \
  --enable-shared
make -j$JOBS
make install
mkdir -p "$DOCDIR/ffmpeg"
cp *.md MAINTAINERS Changelog "$DOCDIR/ffmpeg"

# ffms2
cd ../ffms2
./autogen.sh --prefix="$PFX" --disable-static --enable-shared
make -j$JOBS
make install
mkdir -p "$DOCDIR/ffms2"
cp COPYING "$DOCDIR/ffms2"

# aegisub
cd ../aegisub-wangqr
test -e build/git_version.h || ../gen_version.sh
patch -p1 < ../aegisub-appimage.patch
./autogen.sh
CFLAGS="-Wall -O2" \
CXXFLAGS="-Wall -O2 -std=c++11" \
  ./configure --prefix="$PWD/aegisub.appdir/usr" \
  --disable-compiler-flags \
  --disable-update-checker \
  --disable-rpath \
  --disable-debug \
  --enable-appimage
make -j$JOBS
make install
strip "$APPDIR/usr/bin/aegisub"
mkdir -p "$DOCDIR/aegisub"
cp LICENCE README.md ../aegisub-appimage.patch "$DOCDIR/aegisub"
VERSION=$(grep BUILD_VERSION_STRING Makefile.inc | tr -d '[:blank:]' | cut -d= -f2)
cd ..

# appimage
wget https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous/linuxdeploy-x86_64.AppImage
wget https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-x86_64.AppImage
wget https://github.com/linuxdeploy/linuxdeploy-plugin-gtk/raw/master/linuxdeploy-plugin-gtk.sh
chmod a+x *.sh *.AppImage
./linuxdeploy-x86_64.AppImage --appdir="$APPDIR" --plugin gtk
./appimagetool-x86_64.AppImage --no-appstream "$APPDIR" aegisub-${VERSION}.AppImage

# rename sources
mv sources.tar.xz "aegisub-${VERSION}-sources.tar.xz"

