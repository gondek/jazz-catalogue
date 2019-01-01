#!/bin/bash
set -e
cd `dirname $0`/../

mkdir -p build
jekyll build --quiet
echo "Jekyll Site Built!"
