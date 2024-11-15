__stop_wineserver() {
  # Stop wineserver
  if [[ -x "$wine64_path/bin/wineserver" ]]; then
    "$wine64_path/bin/wineserver" -k &> /dev/null
  fi
  if [[ -x "$wine32_path/bin/wineserver" ]]; then
    "$wine32_path/bin/wineserver" -k &> /dev/null
  fi
}

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

link_wine() {
  info "Installing wine link..."
  require_sudo

  # install 64-bit
  if [[ -L "$wine64_link" ]]; then
    sudo rm -f "$wine64_link"
  fi
  sudo ln -s "$wine64_path" "$wine64_link"

  # install 32-bit
  if [[ -L "$wine32_link" ]]; then
    sudo rm -f "$wine32_link"
  fi
  sudo ln -s "$wine32_path" "$wine32_link"
}

install_wine() {
  __stop_wineserver
  download_wine
  extract_wine
  link_wine
}

# vim: tabstop=2 shiftwidth=2 softtabstop=2
