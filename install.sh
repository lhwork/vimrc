#!/bin/sh

# check ~/.vim and ~/.vimrc
[ -e "~/.vim" ] && die "~/.vim already exists."
[ -e "~/.vimrc" ] && die "~/.vimrc already exists."

# get vimrc
cd ~
git clone git://github.com/lhwork/vimrc.git
cd vimrc

# symlink ~/.vim and ~/.vimrc
ln -s ~/vimrc/vimrc .vimrc
ln -s ~/vimrc/vim .vim

echo "Installed and configured."
