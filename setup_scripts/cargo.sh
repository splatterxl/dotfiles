#!/bin/sh
# Rust Crates

if ! [ -z "$1" ]; then
  echo [info] Not installing selected crates due to network restriction
else
  echo [info] Installing recommended crates...
  echo
  cargo install $(cat cargo.txt)
fi

