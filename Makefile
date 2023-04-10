## Variables used in target commands
SHELL := /bin/bash
ENV ?= Local

## Variables to make targets more readable
ENV_FILE = --env-file ./Envs/${ENV}/variables.env
DOCKER_COMPOSE_FILE = -f ./Envs/${ENV}/docker-compose.yml
DOCKER_COMPOSE = docker-compose ${DOCKER_COMPOSE_FILE} ${ENV_FILE}

## Style to print targets in a nice format
STYLE = {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}


.PHONY: help
help:	## Show this help, which show all the possible make targets and its description.
	@echo ""
	@echo "The following are the make targets you can use in this way 'make <target>':"
	@echo ""
	@awk ' BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / ${STYLE}' $(MAKEFILE_LIST)
	@echo ""
	@echo ""
	@echo "You can interact with docker-compose using the following schema:"
	@echo "${DOCKER_COMPOSE}"

ifeq (docker,$(firstword $(MAKECMDGOALS)))
  ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  $(eval $(ARGS):;@:)
endif
.PHONY: docker
docker: ## Runs docker compose command. Eg: "make docker up FLAGS=-d".
	@${DOCKER_COMPOSE} $(ARGS) ${FLAGS}

.PHONY: bash
bash: ## Open a bash shell in the django container.
	@${DOCKER_COMPOSE} exec app /bin/bash
