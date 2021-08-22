#!/bin/sh
# SSH keyring

path=$HOME/.ssh/id_rsa.pub

if [ -e "$path" ]; then
  if ! grep -q sshkeys:checked .config/setuptool; then
    echo [info] RSA public/private key pair already generated, you should now upload \
      the public key to GitHub:
    echo
    cat $path

    echo sshkeys:checked >> .config/setuptool
  else
    echo [info] Key pair already generated.
  fi
else
  ssh-keygen
  echo [info] key pair generated, you should now upload the new public key to GitHub:
  cat $path
fi

