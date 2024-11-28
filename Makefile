SHELL             := /bin/bash
ROOT_MAKEFILE_DIR := $(realpath $(dir $(realpath $(lastword $(MAKEFILE_LIST)))))
ENV_FILE          := $(ROOT_MAKEFILE_DIR)/scripts/env_setup.sh
INSTALL_INDICATOR := .installed

.DEFAULT_GOAL := dev

$(INSTALL_INDICATOR): package.json Gemfile
	@source $(ENV_FILE) && \
	gem install \
	jekyll \
	bundler && \
	bundle install && \
	npm install -g gulp && \
	npm install
	@touch .installed

install: $(INSTALL_INDICATOR)

dev: $(INSTALL_INDICATOR)
	@source $(ENV_FILE) && \
	bundle exec gulp

prod: $(INSTALL_INDICATOR)
	@source $(ENV_FILE) && \
	bundle exec gulp prod

.PHONY: install dev prod