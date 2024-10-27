download_wine() {
  require_pkg "wget"

  info "Downloading wine..."

  # install 64-bit packages
  if [[ -n "$LINK64" ]]; then
    for pkg in "${DEB64_PKGS[@]}"; do
      if [[ -n "$pkg" ]]; then
        info " downloading 64-bit package: '${pkg}'"
        wget -q -c "${LINK64}/${pkg}"
      fi
    done
  fi

  # install 32-bit packages
  if [[ -n "$LINK32" ]]; then
    for pkg in "${DEB32_PKGS[@]}"; do
      if [[ -n "$pkg" ]]; then
        info " downloading 32-bit package: '${pkg}'"
        wget -q -c "${LINK32}/${pkg}"
      fi
    done
  fi

}
