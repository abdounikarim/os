##
## # Install
##---------------------------------------------------------------------------

.PHONY: install install-brew add-tap-packages install-cask-packages install-cli-packages \
authorize-rectangle open-rectangle install-blackfire-probe install-xdebug create-gitignore-file \
update-default-config install-oh-my-zsh add-zsh-autosuggestion add-zsh-vi-mode add-zsh-fast-syntax change-zsh-theme \
bat-alias global-makefile add-starship-config add-starship-file add-iterm-file activate-hidden-files

install:				## Install dependencies
install: install-brew add-tap-packages install-cask-packages install-cli-packages \
authorize-rectangle open-rectangle install-blackfire-probe install-xdebug create-gitignore-file \
update-default-config install-oh-my-zsh add-zsh-autosuggestion add-zsh-vi-mode add-zsh-fast-syntax change-zsh-theme \
bat-alias global-makefile add-starship-config add-starship-file add-iterm-file activate-hidden-files

install-brew:
						sudo true
						curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | sudo -u $$USER bash

add-tap-packages:
						@grep -v '^#' packages/tap.md | grep -v '^[[:space:]]*$$' | while read -r repository; do \
							repository_name=$$(echo "$$repository" | sed 's/^- //'); \
							if brew tap | grep $$repository_name > /dev/null; then \
								echo "\033[0;33mRepository already installed: $$repository_name\033[m";\
							else \
								echo "\033[0;34m$$repository_name is not installed";\
								brew tap $$repository_name;\
								echo "\033[0;32mRepository installed: $$repository_name\033[m";\
							fi \
						done

install-cask-packages:
						@grep -v '^#' packages/cask.md | grep -v '^[[:space:]]*$$' | while read -r package; do \
							package_name=$$(echo "$$package" | sed 's/^- //'); \
							if brew ls --cask --versions $$package_name > /dev/null; then \
								echo "\033[0;33mPackage already installed: $$package_name\033[m";\
							else \
								echo "\033[0;34m$$package_name is not installed";\
								brew install --cask $$package_name;\
								echo "\033[0;32mPackage installed: $$package_name\033[m";\
							fi \
						done

install-cli-packages:
						@grep -v '^#' packages/cli.md | grep -v '^[[:space:]]*$$' | while read -r package; do \
							package_name=$$(echo "$$package" | sed 's/^- //'); \
							if brew ls --versions $$package_name > /dev/null; then \
								echo "\033[0;33mPackage already installed: $$package_name\033[m";\
							else \
								echo "\033[0;34m$$package_name is not installed";\
								brew install $$package_name;\
								echo "\033[0;32mPackage installed: $$package_name\033[m";\
							fi \
						done

authorize-rectangle:
						xattr -r -d com.apple.quarantine /Applications/Rectangle.app

open-rectangle:
						open -a rectangle

install-blackfire-probe:
						bash -c "$$(curl -L https://installer.blackfire.io/installer.sh)"
						blackfire php:install

install-xdebug:
						pecl install xdebug

create-gitignore-file:
						touch ~/.gitignore
						echo ".idea\n.DS_Store\n" >> ~/.gitignore
						git config --global core.excludesFile ~/.gitignore

update-default-config:
						git config --global push.default current

install-oh-my-zsh:
						curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sudo -u $$USER bash

add-zsh-autosuggestion:
						echo 'source $$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh' >> ~/.zshrc

add-zsh-vi-mode:
						echo 'source $$(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh' >> ~/.zshrc

add-zsh-fast-syntax:
						echo 'source $$(brew --prefix)/opt/zsh-fast-syntax-highlighting/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh' >> ~/.zshrc

change-zsh-theme:
						sed -i '' 's/ZSH_THEME="robbyrussell"/ZSH_THEME="cloud"/' ~/.zshrc

bat-alias:
						echo "alias cat='bat --theme=Dracula'" >> ~/.zshrc

global-makefile:
						echo "alias gmake='make -f $(PWD)/Makefile'" >> ~/.zshrc

add-starship-config:
						echo 'eval "$$(starship init zsh)"' >> ~/.zshrc

add-starship-file:
						mkdir -p ~/.config && cp templates/starship.toml ~/.config/starship.toml

add-iterm-file:
						cp templates/com.googlecode.iterm2.plist ~/Library/Preferences/com.googlecode.iterm2.plist

activate-hidden-files:
						defaults write com.apple.finder AppleShowAllFiles TRUE
						killall Finder

##
## # Update
##---------------------------------------------------------------------------

.PHONY: update

update:					## Update everything
						topgrade

##
## # Remove
##---------------------------------------------------------------------------

.PHONY: remove remove-xdebug delete-xdebug-config delete-gitignore-file delete-nerd-font \
delete-starship-file delete-iterm-file remove-cask-packages remove-cli-packages \
remove-oh-my-zsh remove-brew delete-zshrc-file

remove:					## Remove dependencies
remove:					remove-xdebug delete-xdebug-config delete-gitignore-file delete-nerd-font \
delete-starship-file delete-iterm-file remove-cask-packages remove-cli-packages remove-oh-my-zsh \
remove-brew delete-zshrc-file

remove-xdebug:
						pecl uninstall xdebug

delete-xdebug-config:	PHP_VERSION := $(shell php -v | grep -o 'PHP [0-9]\+\.[0-9]\+' | sed 's/PHP //')
delete-xdebug-config:
						sed -i '' '/zend_extension="xdebug.so"/d' /usr/local/etc/php/$(PHP_VERSION)/php.ini

delete-gitignore-file:
						rm -f ~/.gitignore

delete-nerd-font:
						rm -f ~/Library/Fonts/Hack*

delete-starship-file:
						rm -f ~/.config/starship.toml

delete-iterm-file:
						rm -f ~/Library/Preferences/com.googlecode.iterm2.plist

remove-cask-packages:
						@grep -v '^#' packages/cask.md | grep -v '^[[:space:]]*$$' | while read -r package; do \
							package_name=$$(echo "$$package" | sed 's/^- //'); \
							brew uninstall --cask $$package_name;\
						done

remove-cli-packages:
						@grep -v '^#' packages/cli.md | grep -v '^[[:space:]]*$$' | while read -r package; do \
							package_name=$$(echo "$$package" | sed 's/^- //'); \
							brew uninstall $$package_name;\
						done

remove-oh-my-zsh:
						chmod a+x ~/.oh-my-zsh/tools/uninstall.sh
						~/.oh-my-zsh/tools/uninstall.sh

remove-brew:
						sudo true
						curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh | sudo -u $$USER bash

delete-zshrc-file:
						rm -f ~/.zshrc

##
## # Help
##---------------------------------------------------------------------------

.PHONY: help

help:					## Display help
						@grep -E '(^[a-zA-Z_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-20s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'

.DEFAULT_GOAL := 	help
