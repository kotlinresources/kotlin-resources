#!/usr/bin/env bash

set -e

zip -r website.zip _site

curl \
  -H "Content-Type: application/zip" \
  -H "Authorization: Bearer $NETLIFY_KEY" \
  --data-binary "@website.zip" \
  https://api.netlify.com/api/v1/sites/www.kotlinresources.com/deploys

rm website.zip
