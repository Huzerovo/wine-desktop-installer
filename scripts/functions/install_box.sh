
download_box64() {
  if [[ "$version_box64" == "git" ]]; then
    require_pkg "git"
    info "Cloning repo for box64..."
    git clone "$link_box64_git" "$src_dir_box64" &> /dev/null || die "Failed to clone box64 git repo"
  else
    info "Downloading box64..."
    wget -q -c "$link_box64" -O "$tar_box64" || die "Failed to download box64 archive"
  fi
}

download_box86() {
  if [[ "$version_box86" == "git" ]]; then
    require_pkg "git"
    info "Cloning repo for box86..."
    git clone "$link_box86_git" "$src_dir_box86" &> /dev/null || die "Failed to clone box86 git repo"
  else
    info "Downloading box86..."
    wget -q -c "$link_box86" -O "$tar_box86" || die "Failed to download box86 archive"
  fi
}

download_box() {
  if [[ -n "$version_box64" ]]; then
    download_box64
  else
    warn "Will not download box64"
  fi

  if [[ -n "$version_box86" ]]; then
    download_box86
  else
    warn "Will not download box86"
  fi
}

extract_box64() {
  if [[ -f "$tar_box64" ]]; then
    info " extracting for box64..."
    tar -xzf "$tar_box64" || erro "Failed to extract '$tar_box64'"
  else
    warn "Can not find '$tar_box64' when extracting, ignored."
  fi

}

extract_box86() {
  if [[ -f "$tar_box86" ]]; then
    info " extracting for box86..."
    tar -xzf "$tar_box86" || erro "Failed to extract '$tar_box86'"
  else
    warn "Can not find '$tar_box86' when extracting, ignored."
  fi
}

extract_box() {
  info "Extracting box..."
  if [[ -z "$version_box64" ]] || [[ "$version_box64" == "git" ]]; then
    info "Skip box64"
  else
    extract_box64
  fi
  if [[ -z "$version_box86" ]] || [[ "$version_box86" == "git" ]]; then
    info "Skip box86"
  else
    extract_box86
  fi
}

build_box() {
  if [[ -n "$version_box64" ]]; then
    info "Building box64..."
    build_box64 "$@"
  fi

  if [[ -n "$version_box86" ]]; then
    info "Building box86..."
    build_box86 "$@"
  fi
}

build_box64() {
  if [[ -d "$src_dir_box64" ]]; then
    local tpwd="$PWD"
    mkdir -p "$build_dir_box64"
    cd "$build_dir_box64" || cd_faile "$build_dir_box64"
    {
      cmake "$src_dir_box64" "${cmake_box64[@]}"
      make -j8 --quiet
    } || die "Failed to build box64"
    if [[ -n "$1" ]] && [[ "$1" == "--install" ]]; then
      require_sudo
      sudo make install
    fi
    cd "$tpwd" || cd_failed "$tpwd"
  else
    warn "Can not find box64 source directory '$src_dir_box64', ignored"
  fi
}

build_box86() {
  require_pkg "gcc-arm-linux-gnueabihf"
  if [[ -d "$src_dir_box86" ]]; then
    local tpwd="$PWD"
    mkdir -p "$build_dir_box86"
    cd "$build_dir_box86" || cd_faile "$build_dir_box86"
    {
      cmake "$src_dir_box86" "${cmake_box86[@]}"
      make -j8 --quiet
    } || die "Failed to build box86"
    if [[ -n "$1" ]] && [[ "$1" == "--install" ]]; then
      require_sudo
      sudo make install
    fi
    cd "$tpwd" || cd_failed "$tpwd"
  else
    warn "Can not find box86 source directory '$src_dir_box86', ignored"
  fi
}

install_boxrc() {
  if [[ -n "$version_box64" ]]; then
    if [[ -f "${rc_box64}" ]]; then
      info "Installing box64 rc file"
      cp "${rc_box64}" "$HOME/.box64rc"
    fi
  else
    warn "Ignored box64"
  fi
  if [[ -n "$version_box86" ]]; then
    if [[ -f "${rc_box86}" ]]; then
      info "Installing box86 rc file"
      cp "${rc_box86}" "$HOME/.box86rc"
    fi
  else
    warn "Ignoed box86"
  fi
}

install_box() {
  download_box
  extract_box
  build_box --install
}

# vim: tabstop=2 shiftwidth=2 softtabstop=2
