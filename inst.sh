#!/bin/sh

DOTFILES=".bashrc .gitconfig .gvimrc .vim .vimrc .zsh .zshrc
          .gitmyignore .pystartup"

cd

for I in $DOTFILES
do
  if [ -e "$I" ]; then
    echo "\n => $I already exists, let's save it"
    mv $I $I.bak
  fi
  ln -s dotfiles/$I .
done

# to be factorized when more .config files:
mkdir -p ~/.config/terminator/
ln -s ~/dotfiles/terminator/config ~/.config/terminator/

# A few useful applications:
sudo apt-get update
sudo apt-get install -y zsh gitk vim-gtk wmctrl terminator meld chromium-browser \
  gimp smplayer audacity ia32-libs g++ exuberant-ctags #...

chsh -s $(which zsh)

