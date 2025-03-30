install_wine_replacement() {
  local t_pwd="$PWD"
  info "Installing wine replacement..."
  require_pkg "git"
	if [[ -d "$conf_wine_replacement_3rd" ]]; then
    info "Updating wine-replacement in '$conf_wine_replacement_3rd'..."
    cd "$conf_wine_replacement_3rd" || cd_failed "$conf_wine_replacement_3rd"
    git pull &> /dev/null || die "Failed to update wine-replacement, ignored."
  else
    info "Cloning wine-replacement repo to '$conf_wine_replacement_3rd'..."
    git clone "$conf_wine_replacement_repo" "$conf_wine_replacement_3rd" &> /dev/null \
      || die "Failed to clone wine-replacement"

    cd "$conf_wine_replacement_3rd" || cd_failed "$conf_wine_replacement_3rd"
  fi
  require_sudo
  info "Building and installing wine-replacement..."
  sudo make prefix="$prefix" PREFIX="$prefix" install \
		|| die "Failed to install wine replacement"
  cd "$t_pwd" || cd_failed "$t_pwd"
}

# vim: ts=2 sts=2 sw=2
