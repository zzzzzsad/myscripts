#! /bin/bash

curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
if [ ! -f "~/.vimrc" ]; then
	cp ~/.vimrc ~/.vimrc-bak
fi
cp .vim_global_copy_paste.vim ~
cp ./vimrc ~/.vimrc


