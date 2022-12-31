#!/bin/bash
set -e
SCRIPT_DIR="$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)"

cd "$SCRIPT_DIR"
./gen_version.sh

d=aegisub-appimage
rm -rf sources.tar.xz $d
files="$(ls)"
mkdir $d
cp -r $files $d
tar cvJf sources.tar.xz $d

