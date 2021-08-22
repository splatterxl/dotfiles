#!/bin/sh
if ! [ -e .config/setuptool ]; then
  touch .config/setuptool
fi

# whether to use the network
ping -c1 1.1.1.1 2>/dev/null

export download=$?

if [ "$1" == "nonet" ]; then
  export download=1
fi

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
    echo [info] done
  else
    echo [info] aborted
  fi
}

if ! [ -z "$download" ]; then
  echo [info] network is unreachable or restricted
  br
fi

echo Setup Helper v1
echo 'Copyright (C) 2021 Splatterxl'
br
echo The helper will now set up your environment.

kernel=$(uname -sr)
gnu=$(coreutils --version | head -n 1)

section "OS check"

echo [debug] $kernel
echo [debug] $gnu

br

if [ "$(uname -s)" != "Linux" ]; then
  echo [err] machine is not a GNU/Linux distro
  exit 1
fi

pkg=

check_pkg_man() {
  if ! [ -z "$pkg_man" ]; then return 1; fi
  if which "$1" >/dev/null; then
    pkg_man="$1"
    pkg="$pkg_man $2"
  fi
}

section "Package Manager"
check_pkg_man apt install && check_pkg_man pacman -S

echo [debug] $($pkg_man --version)

if [ -z "$download" ]; then
  echo [info] downloading packages
  $pkg $(cat pkgs)
  echo_done
else
  echo '[info] skipping package download (`nonet` passed)'
fi

section "Configuration"

echo [info] copying configuration...
./install.sh override >/dev/null
chadrc() {
  cp chadrc.lua chadrc.lua~
  mv chadrc.lua~ .config/nvim/lua/chadrc.lua
}
if [ -e .config/nvim/lua ]; then
  chadrc
else
  if [ -z $download ]; then
    echo [info] using NvChad instead of old Nvim config
    cd .config
    git clone https://github.com/NvChad/NvChad
    if [ "$?" == 0 ]; then
      rm -rf nvim
      mv NvChad nvim
      cd ..
      chadrc
      echo_done
    else
      echo [err] something wacky happened when trying to install NvChad
      echo_done
      cd ..
    fi
  else
    echo [warn] Skipping NvChad download
    echo_done
  fi
fi

for x in $(ls setup_scripts); do
  path=setup_scripts/$x
  
  section $(node -e "console.log('$(head $path -n 2 | tail -n 1)'.slice(2))")

  bash $path $download
  if [ "$?" == 3 ]; then
    exit 1
  fi
done
