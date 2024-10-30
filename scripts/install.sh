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
wine64_extract="${wine_desktop}/container/64"
wine32_extract="${wine_desktop}/container/32"

# path where is the wine root
wine64_path="${wine64_extract}/opt/wine-${branch_64}"
wine32_path="${wine32_extract}/opt/wine-${branch_32}"

# DO NOT modify it
wine64_link="/opt/wine64"
wine32_link="/opt/wine32"

# environment file
env_file="${wine_desktop}/00wine-desktop.conf"

################################################################################

usage() {
  cat << __EOF__
Usage wine-script-installer [OPTIONS]

OPTIONS:
    --all                   Do a full installation.
                            This action will stop wineserver
    --install-winetricks    Install or update winetricks
    --install-wine          Install wine
                            This action will stop wineserver
    --install-depends       Install wine depends
    --install-shell         Install shell profile
    --install-start-bin     Install command to start wine desktop
    --install-environment   Install Box64 or Box86 environment

    This is subprocess in install-depends
      --generate-depends    Generate deb package depends
    These are subprocesses in install-wine
      --download-wine       Download the wine deb package
      --extract-wine        Extract files from deb package
      --link-wine           Link wine to PATH
                            This action will stop wineserver

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

# functions for installing wine depends (arm64 ot armhf architecture)
source functions/pre_processing.sh
source functions/generate_depends.sh
source functions/install_depends.sh

# function for install shell profile
source functions/install_shell.sh

# function for install start bin
source functions/install_start_bin.sh

# function for install environment
source functions/install_environment.sh

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

all_installation() {
  install_winetricks
  install_wine
  install_depends
  install_shell
  install_start_bin
  install_environment
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
  --install-winetricks)
    install_winetricks
    ;;
  --install-wine)
    install_wine
    ;;
  --install-wine64)
    unset LINK32
    install_wine
    ;;
  --install-wine32)
    unset LINK64
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
  --install-shell)
    install_shell
    ;;
  --install-start-bin)
    install_start_bin
    ;;
  --install-environment)
    install_environment
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
