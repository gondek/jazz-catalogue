#!/bin/bash
set -e
cd `dirname $0`/../

mkdir -p build
bundle exec jekyll build --quiet
echo "Jekyll Site Built!"
