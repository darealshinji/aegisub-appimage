#!/bin/sh
set -e
set -x

test ! -e Aegisub-wangqr/Makefile.inc || make -C Aegisub-wangqr distclean
test ! -e FFmpeg/config.h || make -C FFmpeg distclean
test ! -e ffms2/Makefile || make -C ffms2 distclean
test ! -e libass/Makefile || make -C libass distclean

if [ -e Aegisub-wangqr/.patch_applied ]; then
  cd Aegisub-wangqr
  patch -p1 -R < ../aegisub-appimage.patch
  rm .patch_applied
  cd ..
fi

rm -rf Aegisub-wangqr/aegisub.appdir
rm -rf usr
rm -f *.AppImage linuxdeploy-plugin-gtk.sh

