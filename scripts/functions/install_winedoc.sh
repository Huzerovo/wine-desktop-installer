download_winedoc() {
  info "Downloading wine document..."

  if [[ -n "$version_wine64" ]]; then
    require_pkg "wget"
    info "  downloading 64-bit package: '$DEB64_DOCS'"
    wget -q -c "${LINK64}/${DEB64_DOCS}" || die "Failed to download '$DEB64_DOCS'"
  fi

  if [[ -n "$version_wine32" ]]; then
    require_pkg "wget"
    info "  downloading 32-bit package: '$DEB32_DOCS'"
    wget -q -c "${LINK32}/${DEB32_DOCS}" || die "Failed to download '$DEB32_DOCS'"
  fi
}

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

install_winedoc() {
  download_winedoc
  extract_winedoc
  link_wine
}

# vim: ts=2 sts=2 sw=2
