#!/usr/bin/bash

################################################################################
# NOTE: DO NOT modify any variable in this file.
################################################################################

source common.sh

source config.sh

check_env

usage() {
  cat << __EOF__
Usage wine-desktop-installer [OPTIONS]

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
    --install-bash-profile  Install shell profile
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

# functions for install box
source functions/install_box.sh

# functions for installing wine (amd64 or x86 architecture)
source functions/install_wine.sh

# functions for installing wine documents
source functions/install_winedoc.sh

# function for installing winetricks
source functions/install_winetricks.sh

# function for installing wine-replacement
source functions/install_wine_replacement.sh

# functions for installing wine depends (arm64 ot armhf architecture)
#source functions/pre_processing.sh
#source functions/generate_depends.sh
#source functions/install_depends.sh

# function for install shell profile
source functions/install_bash_profile.sh

# function for install start bin
source functions/install_start_bin.sh

### Main ###

cd "$wine_desktop" || cd_failed "$wine_desktop"

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
  --help | -h)
    usage
		exit 0
    ;;

  --all)
    all_installation
    ;;

  # box
  --install-box)
    install_box
    ;;
  --download-box)
    download_box
    ;;
  --extract-box)
		download_box
    extract_box
    ;;
  --build-box)
		download_box
		extract_box
    build_box
    ;;
  --install-boxrc)
    install_boxrc
    ;;

  # wine
  --install-wine)
    install_wine
    ;;
  --download-wine)
    download_wine
    ;;
  --extract-wine)
		download_wine
    extract_wine
    ;;
  --generate-depends)
    generate_depends
    ;;
  --install-depends)
    install_depends
    ;;
  --link-wine)
    stop_wineserver
    link_wine
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

  # winetricks
  --install-winetricks)
    install_winetricks
    ;;
	
	# wine-replacement
	--install-wine-replacement)
		install_wine_replacement
		;;

  # shell profile
  --install-bash-profile)
    install_bash_profile
    ;;

  # start bin
  --install-start-bin)
    install_start_bin
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
