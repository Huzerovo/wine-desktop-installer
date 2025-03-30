#!/usr/bin/bash

source common.sh

source config.sh

uninstall_box() {
	if [[ -d "$conf_box64_build" ]] ;then
		make -C "$conf_box64_build" uninstall
	fi
	if [[ -d "$conf_box86_build" ]] ;then
		make -C "$conf_box86_build" uninstall
	fi
}

uninstall_wine() {
  info "Uninstalling wine..."
  rm -f /opt/wine32 \
		/opt/wine64 \
    /usr/local/bin/wine \
    /usr/local/bin/wine64 \
    /usr/local/bin/wineserver &> /dev/null
}

uninstall_winetricks() {
  info "Uninstalling winetricks..."
  rm -f /use/local/bin/winetricks \
    /use/local/share/man/man1/winetricks.1 \
    /use/local/share/applications/winetricks.desktop \
    /use/local/share/metainfo/io.github.winetricks.Winetricks.metainfo.xml \
    /use/local/share/icons/hicolor/scalable/apps/winetricks.svg \
    /use/local/share/bash-completion/completions/winetricks &> /dev/null
}

# wine replacement and helper bin
uninstall_bin() {
  info "Uninstalling bin..."
  rm -f \
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

# vim: tabstop=2 shiftwidth=2 softtabstop=2
