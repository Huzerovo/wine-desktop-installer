info() {
  printf "\033[;32m%s\033[0m\n" "$@"
}

warn() {
  printf "\033[;33m%s\033[0m\n" "$@"
}

erro() {
  printf "\033[;31m%s\033[0m\n" "$@" 1>&2
}

cd_failed() {
  die "Failed to change directory to $1"
}

die() {
  # TODO revert_wine
  erro "$@"
  exit 1
}

require_pkg() {
  if ! which "$1" &> /dev/null; then
    if [[ "$1" == "sudo" ]]; then
      erro "Require 'sudo'"
      die "please install the 'sudo' package and add user to sudoers manually"
    fi
    warn "Require package '$1', installing..."
    sudo apt install "$1" \
      || {
        erro "Failed to install '$1'"
        die "you have to install the package contains '$1' binary"
      }
  fi
}
