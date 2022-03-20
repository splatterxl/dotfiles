#!/bin/sh 
# Command-line Utilities

# github.com/dim-an/cod 

info installing cod...
if ! [ -e $GOBIN/cod ]; then
  debug downloading...
  go get -u github.com/dim-an/cod
  debug setting up...
  grep -q "cod init" $HOME/.zshrc || echo "source <(cod init \$\$ zsh)" >> $HOME/.zshrc 
else 
  debug already installed
fi 
info done!

# download oh-my-zsh 
info installing oh-my-zsh...
if ! [ -d $HOME/.oh-my-zsh/ ]; then
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else 
  debug already installed
fi 
info done! 

# download git-extras 
info installing git-extras...

dir=$(mktemp -t -d git-extras-install.XXXXXXXXXX)
cd "$dir"
debug setting up 'git-extras'....
git clone https://github.com/tj/git-extras.git &> /dev/null
cd git-extras
git checkout
$(git describe --tags $(git rev-list --tags --max-count=1)) &> /dev/null
$sudo make install
cp git-extras/etc/git-extras-completion.zsh $HOME/.zsh/completions/git-extras.zs
debug done!
rm -rf "$dir" 

if ! grep -q "git-extras" $HOME/.zshrc; then
  debug adding to .zshrc...
  echo "source $HOME/.zsh/completions/git-extras.zsh" >> $HOME/.zshrc
  debug done!
fi 
