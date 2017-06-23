#!/usr/bin/env bash

set -e

ruby json-crawler.rb

bundle exec jekyll build
bundle exec jekyll algolia push

# bundle exec htmlproofer ./_site --disable-external
