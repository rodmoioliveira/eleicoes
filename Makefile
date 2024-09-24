#!make

help: ## Display this help screen
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
	awk 'BEGIN {FS = ":.*?## "}; \
	{printf "\033[36m%-25s\033[0m %s\n", $$1, $$2}' | \
	sort

bash-all: bash-fmt bash-check bash-lint ## Run all bash tests

bash-check: ## Check format bash code
	@find . -type f -name "*.sh" | xargs shfmt -i 2 -d

bash-fmt: ## Format bash code
	@find . -type f -name "*.sh" | xargs shfmt -i 2 -w

bash-lint: ## Check lint bash code
	@find . -type f -name "*.sh" | xargs shellcheck -o all

build-prettier: ## Prettify site build output
	./dev/build-prettier.sh

images-resize: ## Resize images
	@./dev/images-resize.sh

validate-site: ## Validate site HTML tags
	@./dev/validate-site.sh

.PHONY: help
.PHONY: bash-all
.PHONY: bash-check
.PHONY: bash-fmt
.PHONY: bash-lint
.PHONY: build-prettier
.PHONY: images-resize
.PHONY: validate-site
