download_winedoc() {
  info "Downloading wine document..."
  if [[ -n "$version_wine64" ]]; then
    require_pkg "wget"
    wget -q -c "${LINK64}/${DEB64_DOCS}" || die "Failed to download '$DEB64_DOCS'"
  fi
  if [[ -n "$version_wine32" ]]; then
    require_pkg "wget"
    wget -q -c "${LINK32}/${DEB32_DOCS}" || die "Failed to download '$DEB32_DOCS'"
  fi
}
