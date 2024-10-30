install_shell() {
  # install bash profile
  info "Installing shell profile"
  require_sudo
  # bash
  sudo mkdir -p "/etc/profile.d"
  info "Installing bash shell profile"
  sudo cp "wine-desktop-profile.sh" "/etc/profile.d/wine-desktop-profile.sh"
}
