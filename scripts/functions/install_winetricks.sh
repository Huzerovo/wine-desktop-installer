# Install or update winetricks from git repo
install_winetricks() {
  require_pkg "git"

  if [[ ! -d "$winetricks_repo" ]]; then
    info "Installing winetricks..."
    git clone https://github.com/Winetricks/winetricks.git "$winetricks_repo" &> /dev/null \
      || die "Failed to install winetricks"
  else
    local t_pwd="$PWD"
    cd "$winetricks_repo" || cd_failed "$winetricks_repo"
    info "Updating winetricks..."
    git pull &> /dev/null || die "Failed to update winetricks"
    cd "$t_pwd" || cd_failed "$t_pwd"
  fi

  require_sudo
  if [[ -L "$winetricks_link" ]]; then
    sudo rm -f "$winetricks_link"
  fi
  sudo ln -s "$winetricks_path" "$winetricks_link" 2> /dev/null
}

# vim: tabstop=2 shiftwidth=2 softtabstop=2
