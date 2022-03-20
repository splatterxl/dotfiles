#!/bin/sh
# Elixir

if ! [ -x "$(command -v iex)" ]; then
  info "Installing Elixir"
  $pkg elixir
fi

if ! [ -d $HOME/.config/elixirls ]; then 
  info "Installing ElixirLS"
  git clone https://github.com/elixir-lsp/elixir-ls $HOME/.config/elixirls 
fi
