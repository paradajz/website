SHELL        := /bin/bash
ROOT_DIR     := /home/ubuntu
ENV_FILE     := $(ROOT_DIR)/.env_setup
NODE_VERSION := 16.13.2

.DEFAULT_GOAL := dev

# node_modules directory is created during container build in ROOT_DIR
# npm expects it to be present in the current directory, so just copy it
node_modules:
	@cp -R $(ROOT_DIR)/node_modules node_modules/

dev: node_modules
	@source $(ENV_FILE) && \
	bundle exec gulp

prod: node_modules
	@source $(ENV_FILE) && \
	bundle exec gulp prod

install:
	@source $(ENV_FILE) && \
	gem install jekyll bundler && \
	mkdir -p $$NVM_DIR && \
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash && \
	. $$NVM_DIR/nvm.sh && \
	nvm install $(NODE_VERSION) && \
	bundle install && \
	npm install -g gulp && \
	npm install

.PHONY: dev prod