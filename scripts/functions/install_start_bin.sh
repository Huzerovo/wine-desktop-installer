install_start_bin() {
  info "Installing wine-desktop"
  require_sudo
  sudo cp "${wine_desktop_installer}/wine-desktop" "${prefix}/bin/wine-desktop"
  chmod +x "${prefix}/bin/wine-desktop"
}

# vim: tabstop=2 shiftwidth=2 softtabstop=2
