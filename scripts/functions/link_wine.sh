# Install wine from WineHQ pre-builed package
link_wine() {
  require_pkg "sudo"

  info "Installing wine link..."

  if [[ -L "$wine_link" ]]; then
    sudo rm -f "$wine_link"
  fi
  sudo ln -sv "$wine_path" "$wine_link"
}
