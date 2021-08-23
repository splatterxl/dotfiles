#!/bin/sh
# Rust Crates

if ! [ -z "$1" ]; then
  info "Not installing selected crates due to network restriction"
else
  info "There are crates to be installed but due to time issues and the amount of time it usually takes,"
  info "I'm not going to do it right now."
  info
  info "If you want to do it yourself, all you need to run is:"
  info "     cargo install $(cat cargo.txt)"
fi

