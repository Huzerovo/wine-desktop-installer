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
