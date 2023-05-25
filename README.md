Aegisub AppImage
----------------

This repository contains scripts to build [Aegisub](https://github.com/wangqr/Aegisub) and bundle it as an [AppImage](https://appimage.github.io/).

See the [release section](https://github.com/darealshinji/aegisub-appimage/releases) for pre-built AppImages and source tarballs.


Build from source
-----------------

You can build it yourself from source, if you want.

Make sure all submodules are downloaded: `git submodule init && git submodule update`

The required build dependencies for Debian/Ubuntu are listed in dependencies.txt.

To install them run `sudo apt install $(cat dependencies.txt)`

Now run the build script: `./build.sh`
