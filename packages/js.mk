# JavaScript toolchain.

js-install: ## Install JavaScript toolchain
		brew install node # https://github.com/nodejs/node
		brew install pnpm # https://github.com/pnpm/pnpm
		brew install --cask webstorm # https://github.com/JetBrains/intellij-community

js-update: js-install ## Update JavaScript toolchain

js-remove: ## Remove JavaScript toolchain
		brew uninstall --force --ignore-dependencies node pnpm
		brew uninstall --cask --force --ignore-dependencies --zap webstorm
