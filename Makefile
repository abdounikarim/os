# macOS provisioning Makefile.
# All package installation and configuration is managed by Ansible
# (see ansible/playbook.yml and ansible/roles/*). This Makefile only
# bootstraps Homebrew + Ansible, then hands off. `make install` runs every
# role; `make install-<role>` (e.g. `make install-php`) runs just one.
# See `make help` for all targets.

.PHONY: install update remove dock-restore dock-save help

install: ## 📦 Install everything
		sudo true
		command -v brew > /dev/null 2>&1 || curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | /bin/bash
		export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$(PATH)"
		brew install ansible
		ansible-playbook ansible/playbook.yml

install-%: ## 📦 Install a single role (common, git, zsh, php, js, ruby, python, cleaner)
		sudo true
		command -v brew > /dev/null 2>&1 || curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | /bin/bash
		export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$(PATH)"
		command -v ansible-playbook > /dev/null 2>&1 || brew install ansible
		ansible-playbook ansible/playbook.yml --tags $*

update: ## 🔄 Update everything
		brew upgrade -y
		ansible-playbook ansible/playbook.yml

update-%: ## 🔄 Update a single role
		ansible-playbook ansible/playbook.yml --tags $*

remove: ## 🗑️ Remove everything and uninstall Homebrew itself
		sudo true
		ansible-playbook ansible/playbook.yml -e pkg_state=absent

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

remove-%: ## 🗑️ Remove a single role
		ansible-playbook ansible/playbook.yml --tags $* -e pkg_state=absent

dock-restore: ## Restore Dock configuration
		cp templates/com.apple.dock.plist ~/Library/Preferences/com.apple.dock.plist
		killall Dock

dock-save: ## Save Dock configuration
		cp ~/Library/Preferences/com.apple.dock.plist templates/com.apple.dock.plist

help:	## ℹ️ Display help
		@grep -hE '(^[a-zA-Z_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-20s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'

.DEFAULT_GOAL := 	help
