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
  erro "$@"
  exit 1
}

os_enable_multiarch() {
  case "$id" in
    debian | ubuntu)
    sudo dpkg --add-architecture armhf && sudo apt-get update &> /dev/null
      ;;
    *)
      die "Unsupported os: $id"
      ;;
  esac
}

os_install_package() {
  case "$id" in
    debian | ubuntu)
      sudo apt-get install -yqq "$1"
      ;;
    *)
      die "Unsupported os: $id"
      ;;
  esac
}

require_pkg() {
  case "$id" in
    debian | ubuntu)
      if ! dpkg-query -W "$1" &> /dev/null; then
        warn "Require package '$1', installing..."
        os_install_package "$1" || erro "Failed to install '$1'"
      fi
      ;;
    *)
      die "Unsupported os $id"
      ;;
  esac
}

# call this function before using the 'sudo' command
require_sudo() {
  if ! sudo --version &> /dev/null; then
    die "You should install 'sudo' manually."
  fi
  warn "This action may require your password to use 'sudo'."
  warn "The default password is your username."
}

check_env() {
  # path where all file will store in
  if [[ -z "$WINE_DESKTOP_CONTAINER" ]]; then
    die "Can not find WINE_DESKTOP_CACHE environment, did you login with 'start-wine-desktop'?"
  fi
}

# vim: tabstop=2 shiftwidth=2 softtabstop=2
