### Configuration for wine ###

#example: devel, staging, or stable (wine-staging 4.5+ requires libfaudio0:i386)
branch_wine64="devel"
branch_wine32="devel"

#example: "9.20"
# NOTE: comment the version can disable installing the wine
version_wine64="9.20"
version_wine32="9.20"

#example: debian, ubuntu
id="debian"

#example (for debian): bullseye, buster, jessie, wheezy, ${VERSION_CODENAME}, etc
dist="bookworm"

#example: -1 (some wine .deb files have -1 tag on the end and some don't)
tag_wine64="-1"
tag_wine32="-1"

### Configuration for box64 and box86

# version for box64, please see https://github.com/ptitSeb/box64/releases
# version for box86, please see https://github.com/ptitSeb/box86/releases
# or use 'git' for git version
# comment the version can disable installing the box
version_box64="0.3.0"
version_box86="0.3.6"

declare -a cmake_box64
cmake_box64=(
  --log-level=ERROR
  -DCMAKE_BUILD_TYPE=RelWithDebInfo
  -DARM_DYNAREC=1
  -DARM64=1
  -DCMAKE_C_COMPILER=gcc
  -DBAD_SIGNAL=ON
)

declare -a cmake_box86
cmake_box86=(
  --log-level=ERROR
  -DCMAKE_BUILD_TYPE=RelWithDebInfo
  -DARM_DYNAREC=1
  -DARM64=1
  -DCMAKE_C_COMPILER=arm-linux-gnueabihf-gcc
  -DBAD_SIGNAL=ON
)

# vim: tabstop=2 shiftwidth=2 softtabstop=2
