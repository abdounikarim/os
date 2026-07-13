# macOS provisioning Makefile.
# Each package under packages/*.mk centralizes both installation and
# configuration for one language/tool group. `make install` runs them all;
# `make <package>-install` (e.g. `make php-install`) runs just one.
# See `make help` for all targets.

PACKAGES := common git zsh php js ruby python cleaner

include $(wildcard packages/*.mk)

.PHONY: install update remove dock-restore dock-save help \
	$(foreach p,$(PACKAGES),$(p)-install $(p)-update $(p)-remove)

install: $(foreach p,$(PACKAGES),$(p)-install) ## 📦 Install every package
		sudo true
		command -v brew > /dev/null 2>&1 || curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | /bin/bash
		export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$(PATH)"

		# Show hidden files in Finder.
		defaults write com.apple.finder AppleShowAllFiles TRUE
		killall Finder

update: ## 🔄 Update every package
		brew upgrade -y
		$(MAKE) $(foreach p,$(PACKAGES),$(p)-update)

remove: $(foreach p,$(PACKAGES),$(p)-remove) ## 🗑️ Remove every package and uninstall Homebrew itself
		sudo true

		###> docker ###
		# Docker Desktop doesn't clean up these binaries on its own:
		# https://docs.docker.com/desktop/uninstall/
		sudo rm -f /usr/local/bin/docker
		sudo rm -f /usr/local/bin/docker-credential-desktop
		sudo rm -f /usr/local/bin/docker-credential-ecr-login
		sudo rm -f /usr/local/bin/docker-credential-osxkeychain
		sudo rm -f /usr/local/bin/hub-tool
		sudo rm -f /usr/local/bin/kubectl
		sudo rm -f /usr/local/bin/kubectl.docker
		sudo rm -f /usr/local/cli-plugins/docker-compose
		###< docker ###

		rm -f ~/Library/Fonts/Hack*

		# Finally, remove Homebrew itself:
		# https://docs.brew.sh/FAQ#how-do-i-uninstall-homebrew
		curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh | sudo /bin/bash
		sudo rm -rf /opt/homebrew

dock-restore: ## Restore Dock configuration
		cp templates/com.apple.dock.plist ~/Library/Preferences/com.apple.dock.plist
		killall Dock

dock-save: ## Save Dock configuration
		cp ~/Library/Preferences/com.apple.dock.plist templates/com.apple.dock.plist

help:	## ℹ️ Display help
		@grep -hE '(^[a-zA-Z_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-20s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'

.DEFAULT_GOAL := 	help
