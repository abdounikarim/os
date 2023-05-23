##
## # Install
##---------------------------------------------------------------------------

.PHONY: install install-brew blackfire-repository install-cask-packages install-cli-packages \
authorize-rectangle open-rectangle install-blackfire-probe install-xdebug create-gitignore-file \
update-default-config install-oh-my-zsh install-zsh-auto add-zsh-autosuggestion install-zsh-vi-mode \
add-zsh-vi-mode install-zsh-fast-syntax add-zsh-fast-syntax change-zsh-theme install-nerd-font \
global-makefile add-starship-config add-starship-file add-iterm-file activate-hidden-files

CASK_PACKAGES = brave-browser bitwarden docker iterm2 notion phpstorm postman rectangle slack sublime-text the-unarchiver
CLI_PACKAGES = git docker mutagen-io/mutagen/mutagen-compose marp-cli starship php composer symfony-cli/tap/symfony-cli blackfire yarn ansible topgrade

install:				## Install dependencies
install: install-brew blackfire-repository install-cask-packages install-cli-packages \
authorize-rectangle open-rectangle install-blackfire-probe install-xdebug create-gitignore-file \
update-default-config install-oh-my-zsh install-zsh-auto add-zsh-autosuggestion install-zsh-vi-mode \
add-zsh-vi-mode install-zsh-fast-syntax add-zsh-fast-syntax change-zsh-theme install-nerd-font \
global-makefile add-starship-config add-starship-file add-iterm-file activate-hidden-files

install-brew:
						sudo true
						curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | sudo -u $$USER bash

blackfire-repository:
						brew tap blackfireio/homebrew-blackfire

install-cask-packages:
						@for v in $(CASK_PACKAGES) ; do \
							if brew ls --cask --versions $$v > /dev/null; then \
								echo "\033[0;33mPackage already installed: $$v\033[m";\
							else \
								echo "\033[0;34m$$v is not installed";\
								brew install --cask $$v;\
								echo "\033[0;32mPackage installed: $$v\033[m";\
							fi \
						done

install-cli-packages:
						@for v in $(CLI_PACKAGES) ; do \
							if brew ls --versions $$v > /dev/null; then \
								echo "\033[0;33mPackage already installed: $$v\033[m";\
							else \
								echo "\033[0;34m$$v is not installed";\
								brew install $$v;\
								echo "\033[0;32mPackage installed: $$v\033[m";\
							fi \
						done

authorize-rectangle:
						xattr -r -d com.apple.quarantine /Applications/Rectangle.app

open-rectangle:
						open -a rectangle

install-blackfire-probe:
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

install-zsh-auto:
						brew install zsh-autosuggestions

add-zsh-autosuggestion:
						echo 'source $$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh' >> ~/.zshrc

install-zsh-vi-mode:
						brew install zsh-vi-mode

add-zsh-vi-mode:
						echo 'source $$(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh' >> ~/.zshrc

install-zsh-fast-syntax:
						brew install zsh-fast-syntax-highlighting

add-zsh-fast-syntax:
						echo 'source $$(brew --prefix)/opt/zsh-fast-syntax-highlighting/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh' >> ~/.zshrc

change-zsh-theme:
						sed -i '' 's/ZSH_THEME="robbyrussell"/ZSH_THEME="cloud"/' ~/.zshrc

install-nerd-font:
						brew tap homebrew/cask-fonts && brew install --cask font-hack-nerd-font

global-makefile:
						echo "alias gmake='make -f ~/Web/macos/Makefile'" >> ~/.zshrc

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
remove-oh-my-zsh remove-brew

remove:					## Remove dependencies
remove:					remove-xdebug delete-xdebug-config delete-gitignore-file delete-nerd-font \
delete-starship-file delete-iterm-file remove-cask-packages remove-cli-packages remove-oh-my-zsh \
remove-brew

remove-xdebug:
						pecl uninstall xdebug

delete-xdebug-config:
						sed -i '' '/zend_extension="xdebug.so"/d' /usr/local/etc/php/8.1/php.ini

delete-gitignore-file:
						rm -f ~/.gitignore

delete-nerd-font:
						rm -f ~/Library/Fonts/Hack*

delete-starship-file:
						rm -f ~/.config/starship.toml

delete-iterm-file:
						rm -f ~/Library/Preferences/com.googlecode.iterm2.plist

remove-cask-packages:
						@for v in $(CASK_PACKAGES) ; do \
							brew uninstall --cask $$v;\
						done

remove-cli-packages:
						@for v in $(CLI_PACKAGES) ; do \
							brew uninstall $$v;\
						done

remove-oh-my-zsh:
						chmod a+x ~/.oh-my-zsh/tools/uninstall.sh
						~/.oh-my-zsh/tools/uninstall.sh

remove-brew:
						sudo true
						curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh | sudo -u $$USER bash

##
## # Help
##---------------------------------------------------------------------------

.PHONY: help

help:					## Display help
						@grep -E '(^[a-zA-Z_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-20s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'

.DEFAULT_GOAL := 	help
