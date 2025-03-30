install_bash_profile() {
  # install bash profile
  require_sudo
  sudo mkdir -p "/etc/profile.d"
  info "Installing bash shell profile"
  sudo cp "${wine_desktop_installer}/wine-desktop-profile.sh" "/etc/profile.d/wine-desktop-profile.sh"
}

# vim: tabstop=2 shiftwidth=2 softtabstop=2
