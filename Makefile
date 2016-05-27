ZPLUG_HOME = $(HOME)/.local/zplug

.PHONY: help install clean

help: ## This help message
	@echo "$$(grep -hE '^\S+:.*##' $(MAKEFILE_LIST) | sed -e 's/:.*##\s*/:/' -e 's/^\(.\+\):\(.*\)/\\033[36m\1\\033[m:\2/' | column -c2 -t -s :)"

install: ## Install dotfiles
	@scripts/chsh.sh
	@./install
	@rm -f $(ZPLUG_HOME)/.cache
	@touch $(HOME)/.dootfiles_install
	@echo
	@echo
	@echo "Run \033[1;36mexec zsh -l\033[0m to replace your login session"
	@echo

clean-links:  ## Removes symlinks
	@scripts/clean-links.sh "$(HOME)" "$(PWD)"

clean-old-links:  ## Removes old dotfiles symlinks
	@scripts/clean-links.sh "$(HOME)" "$(HOME)/dotfiles"
