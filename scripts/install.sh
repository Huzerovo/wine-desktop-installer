#!/usr/bin/bash

source common.sh

source config.sh

check_env

################################################################################

wine_desktop="$WINE_DESKTOP_CONTAINER"

### Configuration for install winetricks ###

# path where the git repo will be clone to
winetricks_repo="${wine_desktop}/winetricks"

# usually not need to change, just a shorthand
winetricks_path="${winetricks_repo}/src/winetricks"

# path where the winetricks main file will be linked to
# NOTE: the path it should be in the $PATH
winetricks_link="/usr/local/bin/winetricks"

################################################################################

### Configuration for wine ###

# configuration for wine package

# NOTE: comment the LINK?? will disable all packages
# uncomment to enable packages

# 64-bit version
LINK64="https://dl.winehq.org/wine-builds/${id}/dists/${dist}/main/binary-amd64"
DEB64_WINE="wine-${branch}-amd64_${version}~${dist}${tag}_amd64.deb"
DEB64_TOOLS="wine-${branch}_${version}~${dist}${tag}_amd64.deb"
#DEB64_DOCS="winehq-${branch}_${version}~${dist}${tag}_amd64.deb"

# 32-bit version
#LINK32="https://dl.winehq.org/wine-builds/${id}/dists/${dist}/main/binary-i386"
DEB32_WINE="wine-${branch}-i386_${version}~${dist}${tag}_i386.deb"
#DEB32_TOOLS="wine-${branch}_${version}~${dist}${tag}_i386.deb"
#DEB32_DOCS="winehq-${branch}_${version}~${dist}${tag}_i386.deb"

declare -a DEB64_PKGS=(
  "$DEB64_WINE"
  "$DEB64_TOOLS"
  "$DEB64_DOCS"
)

declare -a DEB32_PKGS=(
  "$DEB32_WINE"
  "$DEB32_TOOLS"
  "$DEB32_DOCS"
)

# configuration for install wine

# path where the files in package will be extract to
wine_extract="${wine_desktop}/container"

# path where is the wine root
wine_path="${wine_extract}/opt/wine-${branch}"

# DO NOT modify it
wine_link="/opt/wine"

################################################################################

usage() {
  cat << __EOF__
Usage wine-script-installer [OPTIONS]

    NOTE: call without options will do a full installation.

OPTIONS:
    --install-winetricks    Install or update winetricks
    --install-wine          Install wine
    --install-depends       Install wine depends
    --install-shell         Install shell profile
    --install-start-bin     Install command to start wine desktop

    This is subprocess in install-depends
      --generate-depends    Generate deb package depends

    These are subprocesses in install-wine
      --download-wine       Download the wine deb package
      --extract-wine        Extract files from deb package
      --link-wine           Link wine to PATH

    --help, -h              Show this help

__EOF__
  warn "NOTE: See the source code for what the options mean."
}

# function for installing winetricks
source functions/install_winetricks.sh

# functions for installing wine (amd64 or x86 architecture)
source functions/download_wine.sh
source functions/extract_wine.sh
source functions/link_wine.sh

# functions for installing wine depends (arm64 ot armhf architecture)
source functions/pre_processing.sh
source functions/generate_depends.sh
source functions/install_depends.sh

# function for install shell profile
source functions/install_shell.sh

# function for install start bin
source functions/install_start_bin.sh

### Main ###

cd "$wine_desktop" || cd_failed "$wine_desktop"

# Stop wineserver
if which wineserver &> /dev/null; then
  wineserver -k 2> /dev/null
fi

if [[ $# -eq 0 ]]; then
  install_winetricks
  download_wine
  extract_wine
  link_wine
  install_depends
  install_shell
  install_start_bin
fi

while [[ $# -gt 0 ]]; do
  case $1 in
    --install-winetricks)
      install_winetricks
      shift
      ;;
    --install-wine)
      download_wine
      extract_wine
      link_wine
      shift
      ;;
    --download-wine)
      download_wine
      shift
      ;;
    --extract-wine)
      extract_wine
      shift
      ;;
    --link-wine)
      link_wine
      shift
      ;;
    --generate-depends)
      generate_depends
      shift
      ;;
    --install-depends)
      install_depends
      shift
      ;;
    --install-shell)
      install_shell
      shift
      ;;
    --install-start-bin)
      install_start_bin
      shift
      ;;
    --help | -h)
      usage
      exit 0
      ;;
    *)
      die "Unknow option $1"
      ;;
  esac
done

info "OK"
warn "NOTE: You have to clean the deb file cache manually."
warn "NOTE: 'depends.txt' and 'depends-addons.txt' are the list of depends."
warn "      Those files may be used when uninstall wine desktop."

# # remove any old wine-mono/wine-gecko install files
# rm -rf ~/.cache/wine
# # remove any old program shortcuts
# rm -rf ~/.local/share/applications/wine
