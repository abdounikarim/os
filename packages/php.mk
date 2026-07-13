# PHP toolchain: interpreter, Composer, Symfony CLI, Box, PhpStorm, Xdebug, Blackfire.

php-install: ## Install PHP toolchain
		brew tap blackfireio/homebrew-blackfire # https://github.com/blackfireio/homebrew-blackfire
		brew tap box-project/box # https://github.com/box-project/homebrew-box
		brew trust symfony-cli/tap
		brew trust box-project/box
		brew trust blackfireio/blackfire

		brew install php # https://github.com/php/php-src
		brew install composer # https://github.com/composer/composer
		brew install symfony-cli/tap/symfony-cli # https://github.com/symfony-cli/symfony-cli
		brew install box-project/box/box # https://github.com/box-project/box
		brew install --cask phpstorm # https://github.com/JetBrains/intellij-community

		# Blackfire CLI agent + PHP probe: https://blackfire.io/docs/up-and-running/installation
		bash -c "$$(curl -L https://installer.blackfire.io/installer.sh)"
		blackfire php:install

		# Xdebug (PHP debugger/profiler): https://xdebug.org
		pecl install xdebug

		# Symfony plugin for PhpStorm: https://github.com/Haehnchen/idea-php-symfony2-plugin
		phpstorm installPlugins fr.adrienbrault.idea.symfony2plugin

php-update: php-install ## Update PHP toolchain

php-remove: ## Remove PHP toolchain
		brew uninstall --force --ignore-dependencies php composer symfony-cli/tap/symfony-cli box-project/box/box
		brew uninstall --cask --force --ignore-dependencies --zap phpstorm
