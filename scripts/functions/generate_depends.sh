# Extract depends packages name from deb file
#
# @param $1 deb file
# @param $2 architecture string
# @param $3 text file, depends are listed per line
pre_processing() {
  local tmp
  tmp="$(mktemp)"

  info "Preprocessing for '$1'"

  # read depends
  dpkg --info "$1" | grep " Depends:" > "$tmp"

  # remove 'Depends:' string
  sed -i -E -r "s/\s*Depends:\s*//" "$tmp"

  # one package per line
  sed -i -E -r "s/,\s*/,\n/g" "$tmp"

  # remove optional, choose the first pkg
  sed -i -E -r "s/\s*\|.*?,{0,1}$/,/" "$tmp"

  # remove version string
  sed -i -E -r "s/\s*\(.*?\),/,/" "$tmp"

  # remove wine from then optional package's depends
  sed -i -E -r "s/^wine.*$//" "$tmp"

  # remove duplicated pkg
  sort -u "$tmp" -o "$tmp"

  # append architecture string
  if [[ -n "$2" ]]; then
    sed -i -E -r "s/,$/:$2/" "$tmp"
  fi

  cat "$tmp" >> "$3"

  rm "$tmp"
}

generate_depends() {
  if [[ -f "depends.txt" ]]; then
    rm "depends.txt"
  fi

  # get depends for 64-bit packages
  if [[ -n "$version_wine64" ]]; then
    for pkg in "${DEB64_PKGS[@]}"; do
      [ -n "$pkg" ] && pre_processing "$pkg" "arm64" "depends.txt"
    done
  fi

  # get depends for 32-bit packages
  if [[ -n "$version_wine32" ]]; then
    for pkg in "${DEB32_PKGS[@]}"; do
      [ -n "$pkg" ] && pre_processing "$pkg" "armhf" "depends.txt"
    done
  fi

  sort -u "depends.txt" -o "depends.txt"
}

# vim: tabstop=2 shiftwidth=2 softtabstop=2
