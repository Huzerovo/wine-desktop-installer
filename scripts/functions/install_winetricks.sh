# Install or update winetricks from git repo
install_winetricks() {
  require_pkg "git"

  if [[ ! -d "$conf_winetricks_3rd" ]]; then
    info "Installing winetricks..."
    git clone "$conf_winetricks_repo" "$conf_winetricks_3rd" &> /dev/null \
      || die "Failed to install winetricks"
  else
    local t_pwd="$PWD"
    cd "$conf_winetricks_3rd" || cd_failed "$conf_winetricks_3rd"
    info "Updating winetricks..."
    git pull &> /dev/null || die "Failed to update winetricks"
    cd "$t_pwd" || cd_failed "$t_pwd"
  fi

  local t_pwd="$PWD"
  cd "$conf_winetricks_3rd" || cd_failed "$conf_winetricks_3rd"
	make PREFIX="$prefix" prefix="$prefix" install
  cd "$t_pwd" || cd_failed "$t_pwd"
}

# vim: tabstop=2 shiftwidth=2 softtabstop=2
