#!/usr/bin/env bash

set -e

cd scripts && (ruby json-crawler.rb || true) && cd ..

bundle exec jekyll build

cd scripts && (ruby html-cleaner.rb || true) && cd ..

bundle exec jekyll algolia push

# bundle exec htmlproofer ./_site --disable-external
