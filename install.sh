#!/bin/sh
set -e

die() {
  echo "$1"
  exit
}

link_all() {
  for file in "$1/"*; do
    link "$file"
  done
}
link() {
  file="$1"
  filename="${file#*$PWD}"
  outfile=$(echo "${HOME:?WHY IS THE HOME VARIABLE NOT SET WHAT THE FUCK}/$filename" | tr -s /)
  [ "${outfile%/}" = "$HOME" ] && die "Something went wrong and $file was translated to $HOME"
  if [ -e "$outfile" ]; then
    if [ -n "$_override" ]; then
      echo "$outfile exists. Deleting since override command was used"
      rm -rf "$outfile"
    else 
      echo "$outfile exists. Run $0 override to override"
      continue
    fi
  fi
  ln -s "$file" "$outfile"
}

install_dotfiles() {
  mkdir -p "$HOME/.config"

  link_all "$PWD/.config" "$HOME"
  link "$PWD/.zshrc"
  mkdir -p "$HOME/.zsh"
  link_all "$PWD/.zsh" "$HOME"
}

check_dir() {
  [ -d "$1" ] || die "$1 not found or not a directory. Make sure you run this from the correct directory"
}

check_dir .git
check_dir .config
check_dir .zsh
if [ "$1" = "install" ]; then
  install_dotfiles
elif [ "$1" = "override" ]; then
  _override=1
  install_dotfiles
else
  echo "Tool to symlink everything inside .config and .local/bin"
  echo "to respective folder in $HOME"
  echo
  echo "Usage: $0 <install | help>"
fi
