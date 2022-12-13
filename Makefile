MKDIR_CONFIG = $(subst dotfiles, ~, $(wildcard dotfiles/.config/*))
MKDIR_HOME = ~/.stack/ ~/bin/

.PHONY: help
help: ## Prints each target and its associated help message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) |  \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: stow
stow:  ## Run stow in dotfiles directory, linking files to home directory
	@mkdir -p $(MKDIR_CONFIG)
	@echo "\033[1m\033[31mNOTE\033[0m: Ignore BUG warnings, they're spurious"
	stow --target $(HOME) --restow dotfiles

.PHONY: clean
clean:  ## Remove stowed links
	@echo "\033[1m\033[31mNOTE\033[0m: Ignore BUG warnings, they're spurious"
	stow --target $(HOME) -D dotfiles
