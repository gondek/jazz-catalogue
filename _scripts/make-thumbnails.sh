#!/bin/bash
set -e
cd `dirname $0`/../assets/covers
mogrify -resize 60 -path ../thumbnails *.jpg
