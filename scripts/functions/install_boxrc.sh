install_boxrc() {
  if [[ -f "${box64rc}" ]]; then
    info "Installing box64 rc file"
    cp "${box64rc}" "$HOME/.${box64rc}"
  fi
  if [[ -f "${box86rc}" ]]; then
    info "Installing box86 rc file"
    cp "${box86rc}" "$HOME/.${box86rc}"
  fi
}
