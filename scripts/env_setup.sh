#!/bin/bash

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

source ~/.rvm/scripts/rvm
rvm use "$RUBY_VERSION"