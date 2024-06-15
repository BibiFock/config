.PHONY: ${TARGETS}
.DEFAULT_GOAL := help

RIPGREP_VERSION := 11.0.1
RIPGREP_FILE := ripgrep_$(RIPGREP_VERSION)_amd64.deb

define say =
    echo "$1"
endef

define say_red =
    echo "\033[31m$1\033[0m"
endef

define say_green =
    echo "\033[32m$1\033[0m"
endef

define say_yellow =
    echo "\033[33m$1\033[0m"
endef

define say_cyan =
    echo "\033[1m\033[36m$1\033[0m\033[21m"
endef

help:
	@$(call say_yellow,"Usage:")
	@$(call say,"  make [command]")
	@$(call say,"")
	@$(call say_yellow,"Available commands:")
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[32m%s\033[0m___%s\n", $$1, $$2}' | column -ts___

install-packages: ## install all need package for work
	@$(call say_yellow, "[install all needed package]")
	@sudo apt-get install git vim vim-gtk3 fortune terminator npm curl fonts-powerline

load-bash: ## load my bash config
	@$(call say_yellow,"[create bash links]")
	@ln -sf "$(shell pwd)"/bashrc ~/.bashrc
	@ln -sf "$(shell pwd)"/bash_aliases ~/.bash_aliases
	@ln -sf "$(shell pwd)"/bash_prompt ~/.bash_prompt
	@ln -sf "$(shell pwd)"/bash_functions ~/.bash_functions
	@ln -sf "$(shell pwd)"/inputrc ~/.inputrc
	@. ~/.bashrc

load-vim: ## load vim config
	@$(call say_yellow,"[create vim config]")
	@ln -sf "$(shell pwd)"/vimrc ~/.vimrc
	@ln -sf "$(shell pwd)"/vim ~/.vim
	@git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

load-nvim: ## load neo vim
	@$(call say_yellow,"[create neovim config]")
	@ln -sf "$(shell pwd)"/nvim ~/.config/

vim-update: ## update all vim packages
	@$(call say_yellow,"[update vim bundles]")
	@vim -c VundleUpdate -c quitall

load-terminator: ## load terminator conf
	@$(call say_yellow,"[init terminator conf]")
	@rm -rf ~/.config/terminator
	@ln -sf "$(shell pwd)"/terminator ~/.config/

load-bin: ## my bin folder
	@$(call say_yellow,"[link bin dir]")
	@ln -sf "$(shell pwd)"/bin ~/bin

load-git: ## load my git conf
	@$(call say_yellow,"[init git conf]")
	@ln -sf "$(shell pwd)"/gitconfig ~/.gitconfig
	@ln -sf "$(shell pwd)"/gitignore_global ~/.gitignore_global

install-composer: ## install composer in my bin dir
	@$(call say_yellow,"[install composer]")
	@php -r "readfile('https://getcomposer.org/installer');" | php -- --install-dir="$(shell pwd)"/bin
	@mv "$(shell pwd)"/bin/composer.phar "$(shell pwd)"/bin/composer

install-phpcs: ## install phpcs
	@$(call say_yellow,"[install phpcs]")
	@curl -o "$(shell pwd)"/bin/phpcs https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar
	@chmod u+x "$(shell pwd)"/bin/phpcs

install-phpdoc: ## install cli phpdocs
	@$(call say_yellow,"[install phpdoc]")
	@sudo pear install doc.php.net/pman

install-php-cs-fixer: ## download & install php-cs-fixer
	@$(call say_yellow,"[install php-cs-fixer]")
	@wget -o "$(shell pwd)"/bin/php-cs-fixer https://cs.sensiolabs.org/download/php-cs-fixer-v2.phar
	@chmod u+x "$(shell pwd)"/bin/php-cs-fixer
	@rm $(shell pwd)/php-cs-fixer-v2.phar

install-mycli: ## install mycli with debian package
	@$(call say_yellow,"[install mycli]")
	@sudo apt-get install mycli
	## TODO change default password for mysql and create bbr user

install-ripgrep: ## install rip-grep with repo
	@$(call say_yellow,"[install ripgrep v$(RIPGREP_VERSION)]")
	@curl -LO https://github.com/BurntSushi/ripgrep/releases/download/$(RIPGREP_VERSION)/$(RIPGREP_FILE)
	@sudo dpkg -i $(RIPGREP_FILE)
	@rm $(RIPGREP_FILE)

install-fzf: ## install fzf with repo
	@$(call say_yellow,"[install fzf]")
	@git clone --depth 1 https://github.com/junegunn/fzf.git ./fzf
	@fzf/install

create-fortune: ## create my fortune file
	@$(call say_yellow,"[create fortune files]")
	@$(shell pwd)/bin/fortuneUpgrade

install-starship: ## install starship
	@$(call say_yellow,"[install starship]")
	@curl -sS https://starship.rs/install.sh | sh
	@ln -sf "$(shell pwd)"/starship.toml ~/.config/starship.toml

install-ubuntumono-nerdfront: ## install nerd font ubuntu mono
	@$(call say_yellow,"[install ubuntu mono nerd font]")
	@mkdir ~/.fonts/
	@wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/UbuntuMono.zip
	@mv ./UbuntuMono.zip ~/.fonts/
	@cd ~/.fonts/ && unzip UbuntuMono.zip && rm UbuntuMono.zip
	@fc-cache -fv

install-yt-dlp: ## install yt-dlp
	@$(call say_yellow,"[install yt-dlp]")
	@wget https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -O ./bin/yt-dlp
	@chmod a+x ./bin/yt-dlp

all: install-packages \
	load-bash \
	load-vim \
	vim-update \
	load-terminator \
	load-bin \
	load-git \
	install-mycli \
	install-ripgrep \
	install-fzf \
	create-fortune \
	install-starship
