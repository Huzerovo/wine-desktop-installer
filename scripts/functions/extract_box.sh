# Extract box64 and box86
extract_box64() {
  if [[ -f "$tar_box64" ]]; then
    info "Extracting for box64..."
    tar -xzf "$tar_box64" || erro "Failed to extract '$tar_box64'"
  else
    warn "Can not find '$tar_box64' when extracting, ignored."
  fi

}

extract_box86() {
  if [[ -f "$tar_box86" ]]; then
    info "Extracting for box86..."
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

# vim: tabstop=2 shiftwidth=2 softtabstop=2
