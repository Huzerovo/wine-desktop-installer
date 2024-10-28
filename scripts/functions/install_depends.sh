# Install depends from apt source
install_depends() {
  generate_depends

  local depends_pkg
  depends_pkg="$(cat "depends.txt" "depends-addons.txt")"

  require_pkg "sudo"

  # enable multiarch
  info "Enable multiarch and update..."
  sudo dpkg --add-architecture armhf && sudo apt-get update &> /dev/null

  info "Installing depends..."
  warn "Depending on your network, it may take a long time."

  # DO NOT quote the $depends_pkg
  # shellcheck disable=SC2086
  sudo apt-get install -y $depends_pkg &> /dev/null || die "Failed to install depends"
}
