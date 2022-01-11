# Shantea Controls website

Based on [Sera theme](https://themeforest.net/item/sera-onepage-multipurpose-jekyll-theme/17600532).

## Setup

1. [Node 16.13](https://nodejs.org/en/)
    * Install with [nvm](https://github.com/nvm-sh/nvm)
2. [Jekyll](http://jekyllrb.com/)
    * [Requirements](https://jekyllrb.com/docs/installation/other-linux/)
    * `gem install jekyll bundler`
3. Install all gems
    * `bundle install` in repository root
4. Install npm packages
    * `npm install -g gulp`
    * `npm install`

## Development

This will give you file watching, browser synchronisation, auto-rebuild, CSS injecting etc (run in repository root):

```shell
$ bundle exec gulp
```

## Build for production

```shell
$ bundle exec prod
```

Production files will be located in `_site/deploy`.