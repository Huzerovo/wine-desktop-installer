extract_wine() {
  info "Extracting wine..."

  # extract files in 64-bit packages
  if [[ -n "$version_wine64" ]]; then
    mkdir -p "$wine64_extract"
    for pkg in "${DEB64_PKGS[@]}"; do
      if [[ -n "$pkg" ]]; then
        info " extracting 64-bit package: '${pkg}'"
        dpkg-deb -x "$pkg" "$wine64_extract"
      fi
    done
  fi

  # extract files in 32-bit packages
  if [[ -n "$version_wine32" ]]; then
    mkdir -p "$wine32_extract"
    for pkg in "${DEB32_PKGS[@]}"; do
      if [[ -n "$pkg" ]]; then
        info " extracting 32-bit package: '${pkg}'"
        dpkg-deb -x "$pkg" "$wine32_extract"
      fi
    done
  fi
}

# vim: tabstop=2 shiftwidth=2 softtabstop=2
