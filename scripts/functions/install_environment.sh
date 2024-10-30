install_environment() {
  info "Installing environment file"
  if [[ -f "${env_file}" ]]; then
    mkdir -p "$HOME/.config/environment.d"
    cp "${env_file}" "$HOME/.config/environment.d/"
  else
    warn "Can not find environment file, ignored."
  fi
}
