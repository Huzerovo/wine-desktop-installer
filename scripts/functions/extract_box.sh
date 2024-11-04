# Extract box64 and box86
extract_box64() {
  if [[ -f "$tar_box64" ]]; then
    tar -xzf "$tar_box64" || erro "Failed to extract '$tar_box64'"
  else
    warn "Can not find '$tar_box64' when extracting, ignored."
  fi

}

extract_box86() {

  if [[ -f "$tar_box86" ]]; then
    tar -xzf "$tar_box86" || erro "Failed to extract '$tar_box86'"
  else
    warn "Can not find '$tar_box86' when extracting, ignored."
  fi
}

extract_box() {
  if [[ -n "$version_box64" ]]; then
    extract_box64
  fi
  if [[ -n "$version_box86" ]]; then
    extract_box86
  fi
}

# vim: tabstop=2 shiftwidth=2 softtabstop=2
