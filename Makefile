.PHONY: install update check remove help

install:## 📦 Install dependencies
		sudo true
		command -v brew > /dev/null 2>&1 || curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | /bin/bash
		export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$(PATH)"
		brew trust symfony-cli/tap
		brew trust box-project/box
		brew trust blackfireio/blackfire
		brew bundle

		###> rectangle ###
		xattr -r -d com.apple.quarantine /Applications/Rectangle.app
		open -a rectangle
		###< rectangle ###

		###> blackfire ###
		bash -c "$$(curl -L https://installer.blackfire.io/installer.sh)"
		blackfire php:install
		###< blackfire ###

		###> gpg ###
		brew install pinentry-mac
		###< gpg ###

		###> xdebug ###
		pecl install xdebug
		###< xdebug ###

		###> phpstorm ###
		phpstorm installPlugins fr.adrienbrault.idea.symfony2plugin
		###< phpstorm ###

		###> zsh ###
		[ -d "$$HOME/.oh-my-zsh" ] || curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sudo -u $$USER bash
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
		brew trust symfony-cli/tap
		brew trust box-project/box
		brew trust blackfireio/blackfire
		brew upgrade
		brew bundle

		@grep '^cask "' Brewfile | \
		awk -F'"' '{print $$2}' | \
		while read -r cask; do \
		  	brew upgrade --cask $$cask; \
		done

check: ## ✅ Check that the environment is correctly set up
	@echo "Checking environment..."
	@command -v brew > /dev/null 2>&1 && echo "✅ brew" || echo "❌ brew not found"
	@command -v starship > /dev/null 2>&1 && echo "✅ starship" || echo "❌ starship not found"
	@command -v php > /dev/null 2>&1 && echo "✅ php" || echo "❌ php not found"
	@command -v composer > /dev/null 2>&1 && echo "✅ composer" || echo "❌ composer not found"
	@command -v node > /dev/null 2>&1 && echo "✅ node" || echo "❌ node not found"
	@command -v docker > /dev/null 2>&1 && echo "✅ docker" || echo "❌ docker not found"
	@command -v gpg > /dev/null 2>&1 && echo "✅ gpg" || echo "❌ gpg not found"
	@[ -f ~/.gitconfig ] && echo "✅ ~/.gitconfig" || echo "❌ ~/.gitconfig not found"
	@[ -f ~/.zshrc ] && echo "✅ ~/.zshrc" || echo "❌ ~/.zshrc not found"
	@[ -f ~/.config/starship.toml ] && echo "✅ ~/.config/starship.toml" || echo "❌ ~/.config/starship.toml not found"

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
