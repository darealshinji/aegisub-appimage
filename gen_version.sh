#!/bin/bash
set -e
SCRIPT_DIR="$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)"

git submodule status > VERSIONS

cd "$SCRIPT_DIR/Aegisub-wangqr"
mv .git .git_old
ln -s ../.git/modules/Aegisub-wangqr .git
bash build/version.sh .
rm .git
mv .git_old .git
sed -i 's|(unnamed branch)|dev|' build/git_version.h
