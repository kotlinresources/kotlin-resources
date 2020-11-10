#!/usr/bin/env bash

set -e

cd $TRAVIS_BUILD_DIR/scripts && ruby json-crawler.rb

cd $TRAVIS_BUILD_DIR && bundle exec jekyll build

cd $TRAVIS_BUILD_DIR/scripts && ruby html-cleaner.rb

cd $TRAVIS_BUILD_DIR && bundle exec jekyll algolia push

# bundle exec htmlproofer ./_site --disable-external
