dev:
	@bundle exec gulp

prod:
	@bundle exec gulp prod

install:
	@bundle install
	@npm install -g gulp
	@npm install

.PHONY: dev prod