# System/package maintenance tooling.

cleaner-install: ## Install cleaner tooling
		brew install topgrade # https://github.com/topgrade-rs/topgrade

cleaner-update: cleaner-install ## Update cleaner tooling

cleaner-remove: ## Remove cleaner tooling
		brew uninstall --force --ignore-dependencies topgrade
