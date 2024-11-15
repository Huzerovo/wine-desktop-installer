install_replacement() {
  local t_pwd="$PWD"
  info "Installing wine replacement..."
  require_pkg "git"
  if [[ -d "wine-replacement" ]]; then
    info " using exist wine-replacement"
    cd "wine-replacement" || cd_failed "wine-replacement"
    git pull || warn "Failed to update wine-replacement, ignored."
  else
    info " clone wine-replacement repo"
    git clone "https://github.com/Huzerovo/wine-replacement.git" \
      || die "Failed to clone wine-replacement"

    cd "wine-replacement" || cd_failed "wine-replacement"
  fi
  require_sudo
  info " building and installing"
  sudo make install || die "Failed to install wine replacement"
  cd "$t_pwd" || cd_failed "$t_pwd"
}

# vim: ts=2 sts=2 sw=2
