#!/bin/bash
set -e
cd `dirname $0`/../

./_scripts/thumbnails.sh
echo "Thumbnails Generated!"

jekyll build --quiet
echo "Jekyll Site Built!"
