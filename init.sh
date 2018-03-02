#!/bin/bash

sudo apt-get install git vim vim-gtk fortune terminator npm php-pear

ln -sf "$PWD"/bashrc ~/.bashrc
ln -sf "$PWD"/bash_aliases ~/.bash_aliases
ln -sf "$PWD"/bash_prompt ~/.bash_prompt
ln -sf "$PWD"/bash_functions ~/.bash_functions

#vim
ln -sf "$PWD"/vimrc ~/.vimrc
ln -sf "$PWD"/vim ~/.vim
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

#terminator
rm -rf ~/.config/terminator
ln -sf "$PWD"/terminator ~/.config/

#bash
ln -sf "$PWD"/inputrc ~/.inputrc

#bin
ln -sf "$PWD"/bin ~/bin

#git
ln -sf "$PWD"/gitconfig ~/.gitconfig
ln -sf "$PWD"/gitignore_global ~/.gitignore_global

#composer
php -r "readfile('https://getcomposer.org/installer');" | php -- --install-dir="$PWD"/bin
ln -s "$PWD"/bin/composer.phar "$PWD"/bin/composer

# pman (doc php for term)
sudo pear install doc.php.net/pman

# fortune create
$PWD/bin/fortuneUpgrade


