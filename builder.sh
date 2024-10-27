#!/usr/bin/bash

build() {
  if [[ -f "$TARGET" ]]; then
    mv "$TARGET" "${TARGET}.bak"
  fi

  # extract sourced filename
  regex='^\([[:space:]]*\)source[[:space:]]\+\([^[:space:]]\+\)[[:space:]]*$'

  # retain whitespace
  IFS=$'\n'
  prefix="$(dirname "$SRC_SCRIPT")"

  while read -r main_line; do
    sourced=$(echo "$main_line" | sed -n "s/$regex/\2/p")
    if [ -n "$sourced" ]; then
      indent=$(echo "$main_line" | sed -n "s/$regex/\1/p")
      while read -r sourced_line; do
        echo "${indent}${sourced_line}" >> "$TARGET"
      done < "$prefix/$sourced"
    else
      echo "$main_line" >> "$TARGET"
    fi
  done < "$SRC_SCRIPT"

  unset IFS

  if [[ -f "${TARGET}.bak" ]]; then
    rm "${TARGET}.bak"
  fi
}

usage() {
  echo "Usage: $0 src output"
}

if [[ $# -ne 2 ]]; then
  usage
  exit 1
fi

readonly SRC_SCRIPT="$1"
readonly TARGET="$2"

build
