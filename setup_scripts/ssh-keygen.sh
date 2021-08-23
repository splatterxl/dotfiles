#!/bin/sh
# SSH keyring

path=$HOME/.ssh/id_rsa.pub

show_key() {
  info "Key pair $1generated, you should now upload the following text to GitHub."
  info
  info $(cat $path)
  info
  info "(You can always access this at ~/.ssh/id_rsa.pub)"

  echo sshkeys:checked >> .config/setuptool
}

if [ -e "$path" ]; then
  if ! grep -q sshkeys:checked .config/setuptool; then
    show_key "already "
  else
    info "Key pair already generated."
  fi
else
  ssh-keygen
  show_key
fi

