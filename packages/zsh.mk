# zsh plugins and shell config.

zsh-install: ## Install zsh plugins and shell config
		# oh-my-zsh: https://ohmyz.sh
		[ -d "$$HOME/.oh-my-zsh" ] || curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sudo -u $$USER bash

		# Installed as oh-my-zsh custom plugins (not Homebrew) so they load
		# through the plugins=() array like the bundled ones. Directory names
		# must match each plugin's own <name>.plugin.zsh file.
		[ -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ] || git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
		[ -d ~/.oh-my-zsh/custom/plugins/zsh-vi-mode ] || git clone https://github.com/jeffreytse/zsh-vi-mode ~/.oh-my-zsh/custom/plugins/zsh-vi-mode
		[ -d ~/.oh-my-zsh/custom/plugins/fast-syntax-highlighting ] || git clone https://github.com/zdharma-continuum/fast-syntax-highlighting ~/.oh-my-zsh/custom/plugins/fast-syntax-highlighting

		cp templates/.zshrc ~/.zshrc
		echo "alias gmake='make -C $(PWD) -f $(PWD)/Makefile'" >> ~/.zshrc

zsh-update: ## Update zsh plugins and shell config
		git -C ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions pull
		git -C ~/.oh-my-zsh/custom/plugins/zsh-vi-mode pull
		git -C ~/.oh-my-zsh/custom/plugins/fast-syntax-highlighting pull
		$(MAKE) zsh-install

zsh-remove: ## Remove zsh plugins and shell config
		chmod a+x ~/.oh-my-zsh/tools/uninstall.sh
		~/.oh-my-zsh/tools/uninstall.sh
		rm -f ~/.zshrc
