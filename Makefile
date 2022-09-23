.DEFAULT_GOAL := default

SHELL := /bin/bash

.PHONY: run
run:  ## running twitch-speaker
	@bundle exec ruby main.rb

.PHONY: geminstall
geminstall:  ## gem install
	@bundle install

.PHONY: test
test:  ## exec rspec
	@bundle exec rspec
	@bundle exec standardrb --format progress

.PHONY: format
format:  ## fix by standardrb
	@bundle exec standardrb --format progress --fix

.PHONY: help
help:  ## Show all of tasks
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

default: | help
