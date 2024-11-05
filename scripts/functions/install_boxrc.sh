install_boxrc() {
  if [[ -n "$version_box64" ]]; then
    if [[ -f "${rc_box64}" ]]; then
      info "Installing box64 rc file"
      cp "${rc_box64}" "$HOME/.box64rc"
    fi
  else
    warn "Ignored box64"
  fi
  if [[ -n "$version_box86" ]]; then
    if [[ -f "${rc_box86}" ]]; then
      info "Installing box86 rc file"
      cp "${rc_box86}" "$HOME/.box86rc"
    fi
  else
    warn "Ignoed box86"
  fi
}

# vim: tabstop=2 shiftwidth=2 softtabstop=2
