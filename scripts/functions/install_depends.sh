# Install depends from apt source
install_depends() {
  generate_depends

  info "Installing depends..."
  require_sudo
  # TODO: Dependency packages are extract from deb package.
  #       It is not a good way to installing depends.
  local depends_pkg
  depends_pkg=$(cat "depends.txt" "depends-addons.txt")

  # enable multiarch
  info "Enable multiarch and update..."
  sudo dpkg --add-architecture armhf && sudo apt-get update &> /dev/null

  warn "Depending on your network, it may take a long time."

  # DO NOT quote the $depends_pkg
  for pkg in $depends_pkg; do
    os_install_package "$pkg" &> /dev/null \
      || die "Failed to install dependence: $pkg"
  done
}

# vim: tabstop=2 shiftwidth=2 softtabstop=2
