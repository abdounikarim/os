# zsh plugins and shell config.

zsh-install: ## Install zsh plugins and shell config
		brew install zsh-autosuggestions # https://github.com/zsh-users/zsh-autosuggestions
		brew install zsh-fast-syntax-highlighting # https://github.com/zdharma-continuum/fast-syntax-highlighting
		brew install zsh-vi-mode # https://github.com/jeffreytse/zsh-vi-mode

		# oh-my-zsh: https://ohmyz.sh
		[ -d "$$HOME/.oh-my-zsh" ] || curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sudo -u $$USER bash
		cp templates/.zshrc ~/.zshrc
		echo "alias gmake='make -C $(PWD) -f $(PWD)/Makefile'" >> ~/.zshrc

zsh-update: zsh-install ## Update zsh plugins and shell config

zsh-remove: ## Remove zsh plugins and shell config
		brew uninstall --force --ignore-dependencies zsh-autosuggestions zsh-fast-syntax-highlighting zsh-vi-mode
		chmod a+x ~/.oh-my-zsh/tools/uninstall.sh
		~/.oh-my-zsh/tools/uninstall.sh
		rm -f ~/.zshrc
