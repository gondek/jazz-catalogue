#!/bin/bash
set -e
cd `dirname $0`/../assets/_covers
mogrify -resize 100 -path ../thumbnails *.jpg
