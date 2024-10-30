install_environment() {
  info "Installing environment file"
  warn "This action may require sudo privilege"
  if [[ -f "${env_file}" ]]; then
    sudo mkdir -p "/etc/environment.d"
    sudo cp "${env_file}" "/etc/environment.d/"
  else
    warn "Can not find environment file, ignored."
  fi
}
