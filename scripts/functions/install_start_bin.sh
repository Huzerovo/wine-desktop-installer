install_start_bin() {
  chmod +x wine-desktop
  info "Installing wine-desktop"
  require_sudo
  sudo cp wine-desktop /usr/local/bin/wine-desktop
}
