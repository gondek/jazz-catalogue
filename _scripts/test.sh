#!/bin/bash
set -e
cd `dirname $0`/../

# ensure images exist for each post

./_scripts/thumbnails.sh
echo "Thumbnails Generated!"

jekyll build --quiet
