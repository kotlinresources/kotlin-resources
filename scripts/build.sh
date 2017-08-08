#!/usr/bin/env bash

set -e

cd scripts && ruby json-crawler.rb && cd ..

bundle exec jekyll build

cd scripts && ruby html-cleaner.rb && cd ..

bundle exec jekyll algolia push

# bundle exec htmlproofer ./_site --disable-external
