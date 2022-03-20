#!/bin/sh
if ! [ -e .config/setuptool ]; then
  touch .config/setuptool
fi

if [ "$1" == "nonet" ]; then
  export download=1
fi

if [ -x "$(command -v sudo)" ]; then
  sudo="sudo"
fi

sudo() {
  $@
}

br() {
  echo
}

section() {
  br
  echo ---$@---
  br
}

echo_done() {
  if [ "$?" == 0 ]; then
    info "done"
  else
    info "aborted"
  fi
}

# colors
debug() {
  echo "[$grey debug$reset ] $@"
}

err() {
  echo "[$red err!$reset ] $@"
}

info() {
  echo "[$blue info$reset ] $@"
}

warn() {
  echo "[$yellow warn$reset ] $@"
}

strt="$(node -e process.stdout.write'("\x1b")')"
export yellow="$strt[93m"
export blue="$strt[94m"
export grey="$strt[90m"
export red="$strt[91m"
export green="$strt[92m"

export reset="$strt[39m"

if ! [ -z "$download" ]; then
  info "network is unreachable or restricted"
  br
fi

# header
echo Setup Helper v1
echo 'Copyright (C) 2021 Splatterxl'
br
echo The helper will now set up your environment.

# not all commands used in here are linux compatible and it's better to take no chances.
section "OS check"

kernel=$(uname -sr)
gnu=$(coreutils --version | head -n 1)

debug $kernel
debug $gnu

br

if [ "$(uname -s)" != "Linux" ]; then
  err "machine is not a GNU/Linux distro"
  exit 1
fi

check_pkg_man() {
  if ! [ -z "$pkg_man" ]; then return 1; fi
  if which "$1" >/dev/null; then
    export pkg_man="$1"
    export pkg="$pkg_man $2"
    export pkg_un="$pkg_man $3"
    export pkg_installed="$4"
  fi
}

# setting package manager
section "Package Manager"
check_pkg_man apt install uninstall "apt list --installed" && check_pkg_man pacman -S -S "echo -n"

if [ -z "$pkg_man" ]; then
  err "package manager is not APT or pacman"
  exit 1
fi

debug $($pkg_man --version)

if [ -z "$download" ]; then
  info "downloading packages"
  installed="$($pkg_installed)"
  
  echo "$installed" > .config/setuptool_installed_pkgs

  for x in $(cat pkgs); do
    if grep -q $x .config/setuptool_installed_pkgs; then
      debug "$x is already installed, skipping"
    else
      sudo $pkg "$x"
    fi
  done
  echo_done
else
  info 'skipping package download (`nonet` passed)'
fi

# symlink zshrc and .config to homedir 
section "Configuration"

info "copying configuration..."

./install.sh override 2>/dev/null >/dev/null

# copy NvChad configuration to its correct folder 
chadrc() {
  cp chadrc-custom custom -r
  rm -rf .config/nvim/lua/custom
  mv custom .config/nvim/lua/
  nvim +'hi NormalFloat guibg=#1e222a' +PackerSync
}

if [ -e .config/nvim/lua ]; then
  chadrc
else
  if [ -z $download ]; then
    info "using NvChad instead of old Nvim config"

    mv .config/nvim .config/nvim-backup
    git clone https://github.com/NvChad/NvChad .config/nvim

    # it succeeded 
    if [ "$?" == 0 ]; then
      chadrc
      echo_done
    # it didn't
    else
      err "something wacky happened when trying to install NvChad"
      echo_done
      cd ..
    fi
  else
    warn "Skipping NvChad download"
    echo_done
  fi
fi

echo_done

! [ -d $HOME/.zsh/completions ] && mkdir -p $HOME/.zsh/completions

for x in $(ls setup_scripts); do
  path=setup_scripts/$x
  
  section $(node -e "console.log('$(head $path -n 2 | tail -n 1)'.slice(2))")

  source $path
done
