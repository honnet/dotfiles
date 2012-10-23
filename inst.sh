#!/bin/sh

DOTFILES=".bashrc .gitconfig .gvimrc .vim .vimrc .zsh .zshrc .gitmyignore .pystartup"

cd

for I in $DOTFILES
do
  if [ -e "$I" ]; then
    echo "\n => $I already exists, let's save it"
    mv $I $I.bak
  fi
  ln -s dotfiles/$I .
done

sudo apt-get install -y zsh git vim-gnome terminator chromium-browser meld gitk arduino smplayer curl minicom gnome-shell

sudo chsh -s /usr/bin/zsh

