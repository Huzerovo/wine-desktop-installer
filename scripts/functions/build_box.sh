# build box64 or box86
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

# vim: tabstop=2 shiftwidth=2 softtabstop=2
