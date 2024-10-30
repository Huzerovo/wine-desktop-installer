install_start_bin() {
  chmod +x wine-desktop
  warn "Installing wine-desktop, it may require sudo privilege"
  sudo cp wine-desktop /usr/local/bin/wine-desktop
}
