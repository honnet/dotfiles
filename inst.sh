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


# install vim-pathogen:
mkdir -p ~/.vim/autoload ~/.vim/bundle; \
    curl -Sso ~/.vim/autoload/pathogen.vim \
    https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim

# install Vim Git Gutter:
cd ~/.vim/bundle
git clone git://github.com/airblade/vim-gitgutter.git

# install Vim ctrlP for fuzzy file finder
cd ~/.vim
git clone https://github.com/kien/ctrlp.vim.git bundle/ctrlp.vim

exit ##############################################################################

# To install git hooks: TODO: loop on all useful repo
cd ~/thundercracker
ln -s ~/dotfiles/post-commit .git/hooks


