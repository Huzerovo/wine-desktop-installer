download_wine() {
  info "Downloading wine..."

  # install 64-bit packages
  if [[ -n "$version_wine64" ]]; then
    for pkg in "${DEB64_PKGS[@]}"; do
      if [[ -n "$pkg" ]]; then
        info " downloading 64-bit package: '${pkg}'"
        require_pkg "wget"
        wget -q -c "${LINK64}/${pkg}" || die "Failed to download '${pkg}'"
      fi
    done
  fi

  # install 32-bit packages
  if [[ -n "$version_wine32" ]]; then
    for pkg in "${DEB32_PKGS[@]}"; do
      if [[ -n "$pkg" ]]; then
        info " downloading 32-bit package: '${pkg}'"
        require_pkg "wget"
        wget -q -c "${LINK32}/${pkg}" || die "Failed to download '${pkg}'"
      fi
    done
  fi

}

# vim: tabstop=2 shiftwidth=2 softtabstop=2
