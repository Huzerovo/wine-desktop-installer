#!/usr/bin/bash

################################################################################
# NOTE: DO NOT modify any variable in this file.
################################################################################

source common.sh

source config.sh

check_env

wine_desktop="$WINE_DESKTOP_CONTAINER"

################################################################################
# Configuration for winetricks
################################################################################

# path where the git repo will be clone to
winetricks_repo="${wine_desktop}/winetricks"

# the main script
winetricks_path="${winetricks_repo}/src/winetricks"

# path where the winetricks main file will be linked to
# NOTE: the bin path should be in the PATH
winetricks_link="/usr/local/bin/winetricks"

################################################################################
# Configuration for wine
################################################################################

# path where the files in package will be extract to
wine64_extract="${wine_desktop}/container/64"
wine32_extract="${wine_desktop}/container/32"

# path where is the wine root
wine64_path="${wine64_extract}/opt/wine-${branch_wine64}"
wine32_path="${wine32_extract}/opt/wine-${branch_wine32}"

# DO NOT modify it
wine64_link="/opt/wine64"
wine32_link="/opt/wine32"

# 64-bit version
LINK64="https://dl.winehq.org/wine-builds/${id}/dists/${dist}/main/binary-amd64"
DEB64_WINE="wine-${branch_wine64}-amd64_${version_wine64}~${dist}${tag_wine64}_amd64.deb"
DEB64_TOOLS="wine-${branch_wine64}_${version_wine64}~${dist}${tag_wine64}_amd64.deb"
DEB64_DOCS="winehq-${branch_wine64}_${version_wine64}~${dist}${tag_wine64}_amd64.deb"

# 32-bit version
LINK32="https://dl.winehq.org/wine-builds/${id}/dists/${dist}/main/binary-i386"
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
# Configuration for box64 and box86
################################################################################

# $HOME/.box{64|86}rc file
rc_box64="${wine_desktop}/box64rc"
rc_box86="${wine_desktop}/box86rc"

# downloaded source code archive
tar_box64="box64_$version_box64.tar.gz"
tar_box86="box86_$version_box86.tar.gz"

# path for buiding box{64|86}
src_dir_box64="${wine_desktop}/box64-${version_box64}"
src_dir_box86="${wine_desktop}/box86-${version_box86}"
build_dir_box64="${src_dir_box64}/build"
build_dir_box86="${src_dir_box86}/build"

# the git repo
link_box64_git="https://github.com/ptitSeb/box64.git"
link_box86_git="https://github.com/ptitSeb/box86.git"

# the release package
link_box64="https://github.com/ptitSeb/box64/archive/refs/tags/v$version_box64.tar.gz"
link_box86="https://github.com/ptitSeb/box86/archive/refs/tags/v$version_box86.tar.gz"

################################################################################

usage() {
  cat << __EOF__
Usage wine-script-installer [OPTIONS]

OPTIONS:
    --all                   Do a full installation.
                            This action will stop wineserver
    --install-winetricks    Install or update winetricks
    --install-wine          Install wine
                            NOTE: This action will stop wineserver
                                  and will NOT install wine documents
    --install-winedoc       Install wine documents
                            NOTE: This action will only be run when 
                                  '--install-winedoc' specified
    --install-depends       Install wine depends
    --install-shell         Install shell profile
    --install-start-bin     Install command to start wine desktop
    --install-box           Build and install Box64 or Box86 from source
    --install-boxrc         Install Box64 or Box86 rc file for user

    Subprocess in install-depends
      --generate-depends    Generate deb package depends

    Subprocess in install-wine
      --download-wine       Download the wine deb package
      --extract-wine        Extract files from deb package
      --link-wine           Link wine to PATH
                            NOTE: This action will stop wineserver

    Subprocess in install-winedoc
      --download-winedoc    Download the wine document dev package
      --extract-winedoc     Extract files from deb package

    Subprocess in install-box
      --download-box        Download the source files for box64 and box86
      --extract-box         Download the tar files if downloaded from release
      --build-box           Build the box64 and box86
      --link-box            Link box64 and box86 binaty file to PATH

    --help, -h              Show this help

__EOF__
  warn "NOTE: See the source code for what the actions mean."
}

# function for installing winetricks
source functions/install_winetricks.sh

# functions for installing wine (amd64 or x86 architecture)
source functions/download_wine.sh
source functions/extract_wine.sh
source functions/link_wine.sh

# functions for installing wine documents
source functions/download_winedoc.sh
source functions/extract_winedoc.sh

# functions for installing wine depends (arm64 ot armhf architecture)
source functions/pre_processing.sh
source functions/generate_depends.sh
source functions/install_depends.sh

# function for install shell profile
source functions/install_shell.sh

# function for install start bin
source functions/install_start_bin.sh

# functions for install box
source functions/download_box.sh
source functions/extract_box.sh
source functions/build_box.sh
source functions/install_boxrc.sh

### Main ###

cd "$wine_desktop" || cd_failed "$wine_desktop"

stop_wineserver() {
  # Stop wineserver
  if which wineserver &> /dev/null; then
    wineserver -k &> /dev/null
  fi
}

install_wine() {
  stop_wineserver
  download_wine
  extract_wine
  link_wine
}

install_winedoc() {
  download_winedoc
  extract_winedoc
  link_wine
}

install_box() {
  download_box
  extract_box
  build_box --install
}

all_installation() {
  install_winetricks
  install_wine
  install_depends
  install_shell
  install_start_bin
  install_boxrc
}

if [[ $# -eq 0 ]]; then
  erro "Require options."
  usage
  exit 1
fi

case $1 in
  --all)
    all_installation
    ;;

  # winetricks
  --install-winetricks)
    install_winetricks
    ;;

  # wine
  --install-wine)
    install_wine
    ;;
  --download-wine)
    download_wine
    ;;
  --extract-wine)
    extract_wine
    ;;
  --link-wine)
    stop_wineserver
    link_wine
    ;;
  --generate-depends)
    generate_depends
    ;;
  --install-depends)
    install_depends
    ;;
  # wine doc
  --install-winedoc)
    install_winedoc
    ;;
  --download-winedoc)
    download_winedoc
    ;;
  --extract-winedoc)
    extract_winedoc
    ;;

  # shell profile
  --install-shell)
    install_shell
    ;;

  # start bin
  --install-start-bin)
    install_start_bin
    ;;

  # box
  --install-box)
    install_box
    ;;
  --download-box)
    download_box
    ;;
  --extract-box)
    extract_box
    ;;
  --build-box)
    build_box
    ;;
  --install-boxrc)
    install_boxrc
    ;;
  --help | -h)
    usage
    ;;
  *)
    die "Unknow option $1"
    ;;
esac

info "OK"
warn "NOTE: You have to clean the deb file cache manually."
warn "NOTE: 'depends.txt' and 'depends-addons.txt' are the list of depends."
warn "      Those files may be used when uninstall wine desktop."

# vim: tabstop=2 shiftwidth=2 softtabstop=2
