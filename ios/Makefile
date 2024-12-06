##
## # Install
##---------------------------------------------------------------------------

.PHONY: install

install:				## Install dependencies
install:
						## Update everything
						apk update && apk upgrade

						## Install dependencies
						apk add openssl stunnel perl curl

						## Install PHP
						apk add php8 php8-gd php8-json php8-session php8-fileinfo php8-iconv php8-zip php8-mbstring php8-ctype php8-phar php8-curl php8-apache2 php8-openssl

						## Create symlink
						ln -s /usr/bin/php8 /usr/bin/php

						## Install composer
						php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
						php -r "if (hash_file('sha384', 'composer-setup.php') === 'dac665fdc30fdd8ec78b38b9800061b4150413ff2e3b6f88543c636f7cd84f6db9189d43a81e5503cda447da73c7e5b6') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
						php composer-setup.php
						php -r "unlink('composer-setup.php');"
						mv composer.phar /usr/bin/composer

						## Install tools
						apk add zsh
						sh -c "$$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
						echo zsh >> ~/.profile
						git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
						source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
						git clone https://github.com/zdharma-continuum/fast-syntax-highlighting ~/.zsh/fsh
						source ~/.zsh/fsh/fast-syntax-highlighting.plugin.zsh
						git clone https://github.com/jeffreytse/zsh-vi-mode ~/.zsh/zsh-vi-mode
						source ~/.zsh/zsh-vi-mode/zsh-vi-mode.plugin.zsh
						sed -i '' 's/ZSH_THEME="robbyrussell"/ZSH_THEME="cloud"/' ~/.zshrc

##
## # Update
##---------------------------------------------------------------------------

.PHONY: update

update:					## Update everything
						apk update
						apk upgrade

##
## # Help
##---------------------------------------------------------------------------

.PHONY: help

help:					## Display help
						@grep -E '(^[a-zA-Z_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-20s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'

.DEFAULT_GOAL := 	help
