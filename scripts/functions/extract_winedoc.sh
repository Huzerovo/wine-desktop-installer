extract_winedoc() {
  info "Extracting wine documents..."
  if [[ -n "$version_wine64" ]]; then
    mkdir -p "$wine64_extract"
    info " extracting 64-bit package: '${DEB64_DOCS}'"
    dpkg-deb -x "$DEB64_DOCS" "$wine64_extract"
  fi

  # extract files in 32-bit packages
  if [[ -n "$version_wine32" ]]; then
    mkdir -p "$wine32_extract"
    info " extracting 32-bit package: '${DEB32_DOCS}'"
    dpkg-deb -x "$DEB32_DOCS" "$wine32_extract"
  fi
}
