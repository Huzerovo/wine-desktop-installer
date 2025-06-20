################################################################################
# Global configuration
################################################################################

prefix="/usr/local"
wine_desktop="$WINE_DESKTOP_CONTAINER"
wine_desktop_installer="$wine_desktop/installer"
wine_desktop_cache="$wine_desktop/cache"
wine_desktop_3rd="$wine_desktop/3rd"
wine_desktop_log="$wine_desktop/log"

################################################################################
# Configuration for box64 and box86
################################################################################

# NOTE: use 'git' for git version or comment the version can skip install
# version for box64, see https://github.com/ptitSeb/box64/releases
conf_box64_version="0.3.6"
# version for box86, see https://github.com/ptitSeb/box86/releases
conf_box86_version="0.3.8"

# Build command
conf_box86_make_log="$wine_desktop_log/box86_build_$(date +"%Y%m%d_%I_%M_%S").log"
conf_box64_make_log="$wine_desktop_log/box64_build_$(date +"%Y%m%d_%I_%M_%S").log"
conf_box_make_threads=4
declare -a conf_box64_cmake_flags
conf_box64_cmake_flags=(
  -DCMAKE_BUILD_TYPE=RelWithDebInfo
  -DARM_DYNAREC=1
  -DARM64=1
  -DCMAKE_C_COMPILER=gcc
  -DBAD_SIGNAL=ON
)

declare -a conf_box86_cmake_flags
conf_box86_cmake_flags=(
  -DCMAKE_BUILD_TYPE=RelWithDebInfo
  -DARM_DYNAREC=1
  -DCMAKE_C_COMPILER=arm-linux-gnueabihf-gcc
  -DBAD_SIGNAL=ON
)

# DO NOT Modify
# rc file
conf_box64rc="${wine_desktop}/box64rc"
conf_box86rc="${wine_desktop}/box86rc"

# source code archive
conf_box64_tar="${wine_desktop_cache}/box64_${conf_box64_version}.tar.gz"
conf_box86_tar="${wine_desktop_cache}/box86_${conf_box86_version}.tar.gz"

# path for buiding box64/86
conf_box64_3rd="${wine_desktop_3rd}/box64-${conf_box64_version}"
conf_box86_3rd="${wine_desktop_3rd}/box86-${conf_box86_version}"
conf_box64_build="${conf_box64_3rd}/build"
conf_box86_build="${conf_box86_3rd}/build"

# box64/86 git repo
conf_box64_repo="https://github.com/ptitSeb/box64.git"
conf_box86_repo="https://github.com/ptitSeb/box86.git"

# box64/86 release package
conf_box64_tar_link="https://github.com/ptitSeb/box64/archive/refs/tags/v${conf_box64_version}.tar.gz"
conf_box86_tar_link="https://github.com/ptitSeb/box86/archive/refs/tags/v${conf_box86_version}.tar.gz"

################################################################################
# Configuration for wine
################################################################################

# example: devel, staging, or stable (wine-staging 4.5+ requires libfaudio0:i386)
branch_wine64="devel"
branch_wine32="devel"

# example: "9.20"
# NOTE: comment the version can disable installing the wine
#version_wine64="9.20"
# NOTE: it seems that box86 can not run the wine with version higher than 7.15
# See also: https://github.com/ptitSeb/box86/issues/600
version_wine32="9.20"

os="ubuntu"
dist="noble"

#example: -1 (some wine .deb files have -1 tag on the end and some don't)
tag_wine64="-1"
tag_wine32="-1"

# DO NOT Modify

# path where the files in package will be extract to
wine64_extract="${wine_desktop}/container/wine64"
wine32_extract="${wine_desktop}/container/wine32"

# path where is the wine root
wine64_path="${wine64_extract}/opt/wine-${branch_wine64}"
wine32_path="${wine32_extract}/opt/wine-${branch_wine32}"

# DO NOT modify it
wine64_link="/opt/wine64"
wine32_link="/opt/wine32"

# 64-bit version
LINK64="https://dl.winehq.org/wine-builds/${os}/pool/main/w/wine"
DEB64_WINE="wine-${branch_wine64}-amd64_${version_wine64}~${dist}${tag_wine64}_amd64.deb"
DEB64_TOOLS="wine-${branch_wine64}_${version_wine64}~${dist}${tag_wine64}_amd64.deb"
DEB64_DOCS="winehq-${branch_wine64}_${version_wine64}~${dist}${tag_wine64}_amd64.deb"

# 32-bit version
LINK32="https://dl.winehq.org/wine-builds/${os}/pool/main/w/wine"
DEB32_WINE="wine-${branch_wine32}-i386_${version_wine32}~${dist}${tag_wine32}_i386.deb"
DEB32_TOOLS="wine-${branch_wine32}_${version_wine32}~${dist}${tag_wine32}_i386.deb"
DEB32_DOCS="winehq-${branch_wine32}_${version_wine32}~${dist}${tag_wine32}_i386.deb"

declare -a DEB64_PKGS=(
  "$DEB64_WINE"
  "$DEB64_TOOLS"
)

declare -a DEB32_PKGS=(
  "$DEB32_WINE"
  "$DEB32_TOOLS"
)

################################################################################
# Configuration for winetricks
################################################################################

# git repo for winetricks
conf_winetricks_repo="https://github.com/Winetricks/winetricks.git"

# path where the git repo will be clone to
conf_winetricks_3rd="${wine_desktop_3rd}/winetricks"

################################################################################
# Configuration for wine-replacement
################################################################################

conf_wine_replacement_repo="https://github.com/Huzerovo/wine-replacement.git"
conf_wine_replacement_3rd="$wine_desktop_3rd/wine-replacement"

# vim: tabstop=2 shiftwidth=2 softtabstop=2
