# Common CLI tools and desktop apps used regardless of language/stack.

common-install: ## Install common tools and apps
		brew install lsd # https://github.com/lsd-rs/lsd
		brew install bat # https://github.com/sharkdp/bat
		brew install gnupg # https://github.com/gpg/gnupg
		brew install pinentry-mac # https://github.com/GPGTools/pinentry
		brew install marp-cli # https://github.com/marp-team/marp-cli
		brew install starship # https://github.com/starship/starship
		brew install asciinema # https://github.com/asciinema/asciinema
		brew install glow # https://github.com/charmbracelet/glow
		brew install tree # https://github.com/Old-Man-Programmer/tree
		brew install mkcert # https://github.com/FiloSottile/mkcert
		brew install nss # https://github.com/nss-dev/nss
		brew install act # https://github.com/nektos/act
		brew install ansible # https://github.com/ansible/ansible
		brew install --cask font-hack-nerd-font # https://github.com/ryanoasis/nerd-fonts
		brew install --cask docker-desktop # https://github.com/docker/for-mac
		brew install --cask brave-browser # https://github.com/brave/brave-browser
		brew install --cask brave-browser@beta # https://github.com/brave/brave-browser
		brew install --cask firefox # https://github.com/mozilla/firefox
		brew install --cask bitwarden # https://github.com/bitwarden/clients
		brew install --cask iterm2 # https://github.com/gnachman/iTerm2
		brew install --cask insomnia # https://github.com/Kong/insomnia
		brew install --cask rectangle # https://github.com/rxhanson/Rectangle
		brew install --cask slack # https://github.com/slackhq/slack-desktop
		brew install --cask claude # https://claude.ai
		brew install --cask claude-code # https://claude.ai/code
		brew install --cask sublime-text # https://github.com/sublimehq/sublime_text
		brew install --cask superwhisper # https://superwhisper.com
		brew install --cask the-unarchiver # https://github.com/MacPaw/XADMaster

		# Rectangle is quarantined by Gatekeeper on first install; clear it so
		# it opens without a warning, then launch it.
		xattr -r -d com.apple.quarantine /Applications/Rectangle.app
		open -a rectangle

		# Starship prompt config: https://starship.rs
		mkdir -p ~/.config
		cp templates/starship.toml ~/.config/starship.toml

		# iTerm2 preferences: https://iterm2.com
		cp templates/com.googlecode.iterm2.plist ~/Library/Preferences/com.googlecode.iterm2.plist

common-update: common-install ## Update common tools and apps

common-remove: ## Remove common tools and apps
		brew uninstall --force --ignore-dependencies lsd bat gnupg pinentry-mac marp-cli starship asciinema glow tree mkcert nss act ansible
		brew uninstall --cask --force --ignore-dependencies --zap font-hack-nerd-font docker-desktop brave-browser brave-browser@beta firefox bitwarden iterm2 insomnia rectangle slack claude claude-code sublime-text superwhisper the-unarchiver
		rm -f ~/.config/starship.toml
		rm -f ~/Library/Preferences/com.googlecode.iterm2.plist
