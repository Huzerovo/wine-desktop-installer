# Download box from release
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

# vim: tabstop=2 shiftwidth=2 softtabstop=2
