#!/bin/sh
# Rustup

if ! which rustc >/dev/null; then
  err "Rust isn't installed!"
  exit 3
fi

if ! [ -e $HOME/.rustup ]; then
  warn "Rust not installed with Rustup!"
  if node -e "
    '$(uname -a)'.includes('android') ? process.exit(1) : null
    "; then
    info "Not bothering to install with Rustup as OS does not support it"
  else
    if ! [ -z "$1" ]; then warn "Skipping re-installation"; fi
    info "re-installing with Rustup..."
    $pkg_un rust
    # TODO: install rustup
  fi
fi
