#!/usr/bin/env bash

set -e

bundle exec jekyll build
bundle exec jekyll algolia push

# bundle exec htmlproofer ./_site --disable-external
