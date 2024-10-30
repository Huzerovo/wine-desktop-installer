# Install wine from WineHQ pre-builed package
link_wine() {
  info "Installing wine link..."
  require_sudo

  # install 64-bit
  if [[ -L "$wine64_link" ]]; then
    sudo rm -f "$wine64_link"
  fi
  sudo ln -sv "$wine64_path" "$wine64_link"

  # install 32-bit
  if [[ -L "$wine32_link" ]]; then
    sudo rm -f "$wine32_link"
  fi
  sudo ln -sv "$wine32_path" "$wine32_link"
}
