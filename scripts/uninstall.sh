#!/usr/bin/bash

source common.sh

uninstall_wine() {
  info "Uninstalling wine..."
  rm -f /opt/wine &> /dev/null
}

uninstall_winetricks() {
  info "Uninstalling winetricks..."
  rm -f /usr/local/bin/winetricks &> /dev/null
}

# wine replacement and helper bin
uninstall_bin() {
  info "Uninstalling bin..."
  rm -f \
    /usr/local/bin/wine \
    /usr/local/bin/wine64 \
    /usr/local/bin/wineserver \
    /usr/local/bin/start-wine-desktop &> /dev/null
}

# remove pacages
uninstall_depends32() {
  local depends
  depends=$(grep "armhf" "depends.txt")
  require_pkg "sudo"

  if [[ -n "$depends" ]]; then
    info "Unstalling armhf packages..."
    # shellcheck disable=SC2086
    sudo apt-get purge -y --allow-remove-essetial $depends &> /dev/null \
      || die "Failed to remove armhf depends"
  fi

  sudo dpkg --remove-architecture armhf
  sed -i -E -r '/:armhf/d' "depends.txt"
}

if [[ $# -gt 0 ]] && [[ "$1" == "--purge-armhf" ]]; then
  uninstall_depends32
fi

uninstall_wine
uninstall_winetricks
uninstall_bin

info "OK"

if ! [[ $# -gt 0 ]] && [[ "$1" == "--purge-armhf" ]]; then
  warn "Remove depends manully if you want."
  warn " the depends are listed in 'depends.txt' and 'depends-addons.txt'"
  warn " use 'sudo apt-get purge --allow-remove-essential <packages>'"
  warn "Or if you are sure that you don't use multiarch, you can:"
  warn " use '$0 --purge-armhf' remove multiarch depends by this script."
fi
