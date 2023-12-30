SHELL := /bin/bash

ROOT := $(shell pwd)

COMMAND_TEMPLATE := "  \033[36m%s\033[0m %s\n"

TAG := $(shell date '+%Y.%m')

VERSION ?= 3.11-slim

.PHONY: help
help all:
	@if [[ "$(COMMAND)" != "help" && "$(COMMAND)" != "all" ]]; then \
		echo "Available Commands:"; \
		grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(firstword $(MAKEFILE_LIST)) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf $(COMMAND_TEMPLATE), $$1, $$2}'; \
	fi; \

.PHONY: setup
setup: ## Setup a multi-platform builder
	@docker buildx create --name builder; \
	docker buildx use builder; \
	docker buildx inspect --bootstrap; \

.PHONY: build
build: ## Build the latest image
	@docker image build \
		--no-cache \
		--tag andrebienemann/quant:latest \
		--tag andrebienemann/quant:$(TAG) \
		--build-arg VERSION=$(VERSION) \
		$(ROOT); \

.PHONY: publish
publish: ## Publish the latest image
	@docker buildx build \
		--pull --push \
		--platform linux/amd64,linux/arm64 \
		--tag andrebienemann/quant:latest \
		--tag andrebienemann/quant:$(TAG) \
		--build-arg VERSION=$(VERSION) \
		$(ROOT); \
