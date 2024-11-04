install_boxrc() {
  if [[ -f "${rc_box64}" ]]; then
    info "Installing box64 rc file"
    cp "${rc_box64}" "$HOME/.${rc_box64}"
  fi
  if [[ -f "${rc_box86}" ]]; then
    info "Installing box86 rc file"
    cp "${rc_box86}" "$HOME/.${rc_box86}"
  fi
}

# vim: tabstop=2 shiftwidth=2 softtabstop=2
