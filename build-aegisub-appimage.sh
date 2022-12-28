#!/bin/sh
set -e
set -x

git clone https://github.com/wangqr/Aegisub
cd Aegisub
./build/version.sh .
rm -rf .git
cd ..
cp -r Aegisub Aegisub-src

cd Aegisub
patch -p1 < ../aegisub-appimage.patch

./autogen.sh
flags="-fstack-protector-strong -fno-strict-aliasing -D_FORTIFY_SOURCE=2"
CFLAGS="-Wall -O2 $flags" \
CXXFLAGS="-Wall -O2 -std=c++11 $flags" \
LDFLAGS="-Wl,-z,relro" \
  ./configure --prefix="$PWD/aegisub.appdir/usr" \
  --disable-compiler-flags \
  --disable-update-checker \
  --disable-rpath \
  --disable-debug \
  --enable-appimage
make -j4
make install

wget https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous/linuxdeploy-x86_64.AppImage
chmod a+x linuxdeploy-x86_64.AppImage
./linuxdeploy-x86_64.AppImage --appdir=aegisub.appdir

wget https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-x86_64.AppImage
chmod a+x appimagetool-x86_64.AppImage
VERSION=$(grep BUILD_VERSION_STRING Makefile.inc | tr -d '[:blank:]' | cut -d= -f2)
./appimagetool-x86_64.AppImage --no-appstream aegisub.appdir ../aegisub-${VERSION}.appimage

