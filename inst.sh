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
sudo apt-get install -y zsh vim-gtk terminator meld chromium-browser mplayer gitk \
     uuid-dev libusb-1.0-0-dev mesa-common-dev libglu1-mesa-dev libasound2-dev \
     openocd doxygen g++ upx-ucl ia32-libs python-imaging

chsh -s $(which zsh)

