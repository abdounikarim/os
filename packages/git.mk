# git-related CLI tools and config.

git-install: ## Install git tools and config
		brew install gh # https://github.com/cli/cli

		cp templates/.gitignore ~/.gitignore
		cp templates/.gitconfig ~/.gitconfig

git-update: git-install ## Update git tools and config

git-remove: ## Remove git tools and config
		brew uninstall --force --ignore-dependencies gh
		rm -f ~/.gitignore
