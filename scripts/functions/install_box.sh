__download_box64() {
  if [[ "$conf_box64_version" == "git" ]]; then
    require_pkg "git"
		if [[ -d "$conf_box64_3rd" ]]; then
			local t_pwd="$PWD"
			cd "$conf_box64_3rd" || cd_failed "$conf_box64_3rd"
			info "Updating repo for box64 in '$conf_box64_3rd'..."
			git pull &> /dev/null || die "Failed to update box64 git repo"
			cd "$t_pwd" || cd_failed "$t_pwd"
		else
			info "Cloning repo for box64 to '$conf_box64_3rd'..."
			git clone "$conf_box64_repo" "$conf_box64_3rd" &> /dev/null || die "Failed to clone box64 git repo"
		fi
  else
    info "Downloading box64 to '$conf_box64_tar'..."
    wget -q -c "$conf_box64_tar_link" -O "$conf_box64_tar" || die "Failed to download box64 archive"
  fi
}

__download_box86() {
  if [[ "$conf_box86_version" == "git" ]]; then
    require_pkg "git"
		if [[ -d "$conf_box86_3rd" ]]; then
			local t_pwd="$PWD"
			cd "$conf_box86_3rd" || cd_failed "$conf_box86_3rd"
			info "Updating repo for box86 in '$conf_box86_3rd'..."
			git pull &> /dev/null || die "Failed to update box86 git repo"
			cd "$t_pwd" || cd_failed "$t_pwd"
		else
			info "Cloning repo for box86 to '$conf_box86_3rd'..."
			git clone "$conf_box86_repo" "$conf_box86_3rd" &> /dev/null || die "Failed to clone box86 git repo"
		fi
  else
    info "Downloading box86 to '$conf_box64_tar'..."
    wget -q -c "$conf_box86_tar_link" -O "$conf_box86_tar" || die "Failed to download box86 archive"
  fi
}

__extract_box64() {
  if [[ -f "$conf_box64_tar" ]]; then
    info " extracting for box64..."
    tar -xzf "$conf_box64_tar" || erro "Failed to extract '$conf_box64_tar'"
  else
    warn "Can not find '$conf_box64_tar' when extracting, ignored."
  fi

}

__extract_box86() {
  if [[ -f "$conf_box86_tar" ]]; then
    info " extracting for box86..."
    tar -xzf "$conf_box86_tar" || erro "Failed to extract '$conf_box86_tar'"
  else
    warn "Can not find '$conf_box86_tar' when extracting, ignored."
  fi
}

__build_box64() {
  if [[ -d "$conf_box64_3rd" ]]; then
    local tpwd="$PWD"
		if [[ -d "$conf_box64_build" ]] ; then
			warn "Use exist box64 build"
			#rm -rf "$conf_box64_build"
		else
			mkdir -p "$conf_box64_build"
		fi
    cd "$conf_box64_build" || cd_faile "$conf_box64_build"
    {
      cmake "$conf_box64_3rd" "${conf_box64_cmake_flags[@]}"
      make -j "$conf_box_make_threads"
    } &> "$conf_box64_make_log" || die "Failed to build box64"
    if [[ "$1" == "--install" ]]; then
      require_sudo
      sudo make install &> /dev/null
    fi
    cd "$tpwd" || cd_failed "$tpwd"
  else
    warn "Can not find box64 source directory '$conf_box64_3rd', ignored"
  fi
}

__build_box86() {
  require_pkg "gcc-arm-linux-gnueabihf"
  if [[ -d "$conf_box86_3rd" ]]; then
    local tpwd="$PWD"
		if [[ -d "$conf_box86_build" ]] ; then 
			warn "Use exist box86 build"
		  #rm -rf "$conf_box86_build"
		else
			mkdir -p "$conf_box86_build"
		fi
    cd "$conf_box86_build" || cd_faile "$conf_box86_build"
    {
      cmake "$conf_box86_3rd" "${conf_box86_cmake_flags[@]}"
      make -j "$conf_box_make_threads"
    } &> "$conf_box86_make_log" || die "Failed to build box86"
    if [[ "$1" == "--install" ]]; then
      require_sudo
      sudo make install &> /dev/null
    fi
    cd "$tpwd" || cd_failed "$tpwd"
  else
    warn "Can not find box86 source directory '$conf_box86_3rd', ignored"
  fi
}

download_box() {
	info "Getting source code for box64/86..."
  if [[ -n "$conf_box64_version" ]]; then
    __download_box64
  else
    warn "Skip box64"
  fi

  if [[ -n "$conf_box86_version" ]]; then
    __download_box86
  else
    warn "Skip box86"
  fi
}

extract_box() {
  info "Extracting source code for box64/86..."
  if [[ -z "$conf_box64_version" ]] || [[ "$conf_box64_version" == "git" ]]; then
    warn "Skip box64"
  else
    __extract_box64
  fi
  if [[ -z "$conf_box86_version" ]] || [[ "$conf_box86_version" == "git" ]]; then
    warn "Skip box86"
  else
    __extract_box86
  fi
}

build_box() {
  if [[ -n "$conf_box64_version" ]]; then
    info "Building box64..."
    __build_box64 "$@"
  fi

  if [[ -n "$conf_box86_version" ]]; then
    info "Building box86..."
    __build_box86 "$@"
  fi
}

install_box() {
  download_box
  extract_box
  build_box --install
}

install_boxrc() {
  if [[ -n "$conf_box64_version" ]]; then
    if [[ -f "${conf_box64rc}" ]]; then
      info "Installing box64 rc file"
      cp "${conf_box64rc}" "$HOME/.box64rc"
    fi
  else
    warn "Ignored box64"
  fi
  if [[ -n "$conf_box86_version" ]]; then
    if [[ -f "${conf_box86rc}" ]]; then
      info "Installing box86 rc file"
      cp "${conf_box86rc}" "$HOME/.box86rc"
    fi
  else
    warn "Ignoed box86"
  fi
}

# vim: tabstop=2 shiftwidth=2 softtabstop=2
