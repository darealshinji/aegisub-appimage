#!/bin/bash
set -e
SCRIPT_DIR="$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)"

git submodule status > VERSIONS

# aegisub
cd "$SCRIPT_DIR/aegisub-wangqr"
mv .git .git_old
ln -s ../.git/modules/aegisub-wangqr .git
bash build/version.sh .
rm .git
mv .git_old .git
