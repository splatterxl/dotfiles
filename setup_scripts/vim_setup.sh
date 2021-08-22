#!/bin/sh
# Nvim Setup

install_plugins() {
  echo
  echo [info] installing plugins...
  echo '(waiting for your editor to close)'
    
  nvim +PlugInstall +qall

  echo
  echo [info] done!
}

skip() {
  echo
  echo [warn] $1 skipped!
  echo [note] you should retry without a network restriction, as neovim will error until after $1 occurs
}

if ! [ -e "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim ]; then
  echo [info] vim-plug extension not found!
  if [ -z "$1" ]; then
    echo [info] installing...
    echo
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
  	  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    echo
    echo [info] done
    install_plugins
  else
    skip "vim-plug installation"
  fi
else
  echo [info] vim-plug already installed! :D
  if [ -z "$1" ]; then
    install_plugins
  else
    skip "plugin installation"
  fi
fi
