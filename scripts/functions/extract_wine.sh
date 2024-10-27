extract_wine() {
  # remove old files
  if [[ -d "$wine_extract" ]]; then
    rm -rf "$wine_extract"
  fi

  info "Extracting wine..."

  # extract files in 64-bit packages
  if [[ -n "$LINK64" ]]; then
    for pkg in "${DEB64_PKGS[@]}"; do
      if [[ -n "$pkg" ]]; then
        info " extracting 64-bit package: '${pkg}'"
        dpkg-deb -x "$pkg" "$wine_extract"
      fi
    done
  fi

  # extract files in 32-bit packages
  if [[ -n "$LINK32" ]]; then
    for pkg in "${DEB32_PKGS[@]}"; do
      if [[ -n "$pkg" ]]; then
        info " extracting 32-bit package: '${pkg}'"
        dpkg-deb -x "$pkg" "$wine_extract"
      fi
    done
  fi
}
