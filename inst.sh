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

# TODO: improve list useful application
inst zsh git gvim-gnome terminator meld chromium-browser \
     gimp smplayer audacity #...

chsh -s $(which zsh)

