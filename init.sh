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

#zsh
curl -L http://install.ohmyz.sh | sh
ln -sf "$PWD"/zshrc ~/.zshrc
ln -sf "$PWD"/bbr.zsh-theme ~/.oh-my-zsh/themes/bbr.zsh-theme

#bash
ln -sf "$PWD"/inputrc ~/.inputrc

#bin
ln -sf "$PWD"/bin ~/bin

#git
ln -sf "$PWD"/gitconfig ~/.gitconfig
ln -sf "$PWD"/gitignore_global ~/.gitignore_global

#composer
php -r "readfile('https://getcomposer.org/installer');" | php -- --install-dir="$PWD"/bin


