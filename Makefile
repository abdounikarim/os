.PHONY: install update remove help

install:## 📦 Install dependencies
		sudo true
		curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | sudo -u $$USER bash
		brew bundle

		###> rectangle ###
		xattr -r -d com.apple.quarantine /Applications/Rectangle.app
		open -a rectangle
		###< rectangle ###

		###> xdebug ###
		pecl install xdebug
		###< xdebug ###

		###> phpstorm ###
		phpstorm installPlugins fr.adrienbrault.idea.symfony2plugin
		###< phpstorm ###

		###> zsh ###
		curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sudo -u $$USER bash
		cp templates/.zshrc ~/.zshrc
		###< zsh ###

		###> templates ###
		cp templates/.gitignore ~/.gitignore
		cp templates/.gitconfig ~/.gitconfig
		mkdir -p ~/.config
		cp templates/starship.toml ~/.config/starship.toml
		cp templates/com.googlecode.iterm2.plist ~/Library/Preferences/com.googlecode.iterm2.plist
		###< templates ###

		defaults write com.apple.finder AppleShowAllFiles TRUE
		killall Finder

update:	## 🔄 Update everything, first cli and then casks
		brew bundle

		@grep '^cask "' Brewfile | \
		sed 's/^cask "\(.*\)"/\1/' | \
		while read -r cask; do \
		  	brew upgrade --cask $$cask; \
		done

remove: ## 🗑️ Remove dependencies
		###> xdebug ###
		pecl uninstall xdebug
		PHP_VERSION := $(shell php -v | grep -o 'PHP [0-9]\+\.[0-9]\+' | sed 's/PHP //')
		sed -i '' '/zend_extension="xdebug.so"/d' /usr/local/etc/php/$(PHP_VERSION)/php.ini
		###< xdebug ###

		rm -f ~/.gitignore
		rm -f ~/Library/Fonts/Hack*
		rm -f ~/.config/starship.toml
		rm -f ~/Library/Preferences/com.googlecode.iterm2.plist
		chmod a+x ~/.oh-my-zsh/tools/uninstall.sh
		~/.oh-my-zsh/tools/uninstall.sh
		sudo true
		curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh | sudo -u $$USER bash
		rm -f ~/.zshrc

help:	## ℹ️ Display help
		@grep -E '(^[a-zA-Z_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-20s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'

.DEFAULT_GOAL := 	help
