.PHONY: install update remove help

install:## Install dependencies
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
		echo 'source $$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh' >> ~/.zshrc
		echo 'source $$(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh' >> ~/.zshrc
		echo 'source $$(brew --prefix)/opt/zsh-fast-syntax-highlighting/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh' >> ~/.zshrc
		sed -i '' 's/ZSH_THEME="robbyrussell"/ZSH_THEME="cloud"/' ~/.zshrc
		echo "alias ls='lsd'" >> ~/.zshrc
		echo "alias cat='bat --theme=Dracula'" >> ~/.zshrc
		echo "alias gmake='make -f $(PWD)/Makefile'" >> ~/.zshrc
		echo 'eval "$$(starship init zsh)"' >> ~/.zshrc
		echo "export GPG_TTY=$(tty)" >> ~/.zshrc
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

update:	## Update everything
		brew bundle

remove: ## Remove dependencies
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

help:	## Display help
		@grep -E '(^[a-zA-Z_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-20s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'

.DEFAULT_GOAL := 	help
