install_shell() {
  # install bash profile

  # bash
  sudo mkdir -p "/etc/profile.d"
  info "Installing bash shell profile"
  sudo cp "wine-desktop-profile.sh" "/etc/profile.d/wine-desktop-profile.sh"
}
