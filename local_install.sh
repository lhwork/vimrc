#!/bin/sh

# check ~/.vim and ~/.vimrc
[ -e "~/.vim" ] && die "~/.vim already exists."
[ -e "~/.vimrc" ] && die "~/.vimrc already exists."

INSTALL_DIR=$(pwd)

ln -s $INSTALL_DIR/vimrc ~/.vimrc
ln -s $INSTALL_DIR/vim ~/.vim

echo "Installed and configured."
