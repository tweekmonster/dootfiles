ZPLUG_HOME = $(HOME)/.local/zplug

.PHONY: help install clean

help: ## This help message
	@echo "$$(grep -hE '^\S+:.*##' $(MAKEFILE_LIST) | sed -e 's/:.*##\s*/:/' -e 's/^\(.\+\):\(.*\)/\\033[36m\1\\033[m:\2/' | column -c2 -t -s :)"

install: ## Install dotfiles
	@scripts/chsh.sh
	@./install
	@rm -f $(ZPLUG_HOME)/.cache
	@rehash
	@echo "log back in to ensure changes take effect"

clean-links:  ## Removes symlinks
	@scripts/clean-links.sh "$(HOME)" "$(PWD)"

clean-old-links:  ## Removes old dotfiles symlinks
	@scripts/clean-links.sh "$(HOME)" "$(HOME)/dotfiles"
