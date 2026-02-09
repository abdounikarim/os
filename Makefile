.PHONY: install update remove help

install:## 📦 Install dependencies
		sudo true
		curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | /bin/bash
		eval /opt/homebrew/bin/brew shellenv
		brew bundle

		###> rectangle ###
		xattr -r -d com.apple.quarantine /Applications/Rectangle.app
		open -a rectangle
		###< rectangle ###

		###> blackfire ###
		bash -c "$$(curl -L https://installer.blackfire.io/installer.sh)"
		blackfire php:install
		###< blackfire ###

		###> xdebug ###
		pecl install xdebug
		###< xdebug ###

		###> phpstorm ###
		phpstorm installPlugins fr.adrienbrault.idea.symfony2plugin
		###< phpstorm ###

		###> zsh ###
		curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sudo -u $$USER bash
		cp templates/.zshrc ~/.zshrc
		echo "alias gmake='make -f $(PWD)/Makefile'" >> ~/.zshrc
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
		sudo true

		## Remove all brew packages
		cat Brewfile | grep '^brew ' | awk -F'"' '{print $2}' | xargs brew uninstall --force --ignore-dependencies
		cat Brewfile | grep '^cask ' | awk -F'"' '{print $2}' | xargs brew uninstall --cask --force --ignore-dependencies --zap

		###> docker ###
		sudo rm -f /usr/local/bin/docker
		sudo rm -f /usr/local/bin/docker-credential-desktop
		sudo rm -f /usr/local/bin/docker-credential-ecr-login
		sudo rm -f /usr/local/bin/docker-credential-osxkeychain
		sudo rm -f /usr/local/bin/hub-tool
		sudo rm -f /usr/local/bin/kubectl
		sudo rm -f /usr/local/bin/kubectl.docker
		sudo rm -f /usr/local/cli-plugins/docker-compose
		###< docker ###

		rm -f ~/.gitignore
		rm -f ~/Library/Fonts/Hack*
		rm -f ~/.config/starship.toml
		rm -f ~/Library/Preferences/com.googlecode.iterm2.plist
		chmod a+x ~/.oh-my-zsh/tools/uninstall.sh
		~/.oh-my-zsh/tools/uninstall.sh
		curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh | sudo /bin/bash
		rm -f ~/.zshrc
		sudo rm -rf /opt/homebrew

dock-restore: ## Restore Dock configuration
		cp templates/com.apple.dock.plist ~/Library/Preferences/com.apple.dock.plist
		killall Dock

dock-save: ## Save Dock configuration
		cp ~/Library/Preferences/com.apple.dock.plist templates/com.apple.dock.plist

help:	## ℹ️ Display help
		@grep -E '(^[a-zA-Z_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-20s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'

.DEFAULT_GOAL := 	help
