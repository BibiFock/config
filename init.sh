#!/bin/bash

ln -sf "$PWD"/bashrc ~/.bashrc
ln -sf "$PWD"/bash_aliases ~/.bash_aliases
ln -sf "$PWD"/bash_prompt ~/.bash_prompt
ln -sf "$PWD"/bash_functions ~/.bash_functions

#vim
ln -sf "$PWD"/vimrc ~/.vimrc
ln -sf "$PWD"/vim ~/.vim
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

#tmux
ln -sf "$PWD"/tmux.conf ~/.tmux.conf

#git
ln -sf "$PWD"/gitconfig ~/.gitconfig
ln -sf "$PWD"/gitignore_global ~/.gitignore_global



