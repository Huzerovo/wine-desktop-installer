install_replacement() {
  info "Installing wine replacement..."
  require_pkg "git"
  info " clone wine-replacement repo"
  git clone "https://github.com/Huzerovo/wine-replacement.git" || die "Failed to clone wine-replacement"
  cd "wine-replavcment" || cd_failed "wine-replacement"
  require_sudo
  info " building and installing"
  sudo make install || die "Failed to install wine replacement"
}
