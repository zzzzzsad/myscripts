#! /bin/bash

dir=~/.vim/autoload

if [ ! -d $dir ];then
	mkdir -p $dir
fi

# curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
cp vim-plug_master_plug.vim $dir/plug.vim

cp vim_global_copy_paste.vim ~/.vim_global_copy_paste.vim
cp ./vimrc ~/.vimrc
cp ./tmux.conf ~/.tmux.conf

