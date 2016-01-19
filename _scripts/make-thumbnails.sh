#!/bin/bash
set -e
cd `dirname $0`/../assets/covers
mogrify -resize 75 -path ../thumbnails *.jpg
