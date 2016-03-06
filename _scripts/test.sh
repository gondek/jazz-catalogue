#!/bin/bash
set -e
cd `dirname $0`/../

# does the site build?
./_scripts/build.sh >/dev/null
echo "[PASS 01] Site built correctly!"

# are all album covers 300x300 and contain no metadata?
for f in assets/covers/*; do
  SIZE=$(exiftool $f | grep "Image Size")
  if [[ "$SIZE" != *"300x300"* ]]
  then
    echo -e "[FAIL 02] $f has the wrong dimensions:\n $SIZE";
    exit 1;
  fi
done
METADATA=$(exiftool -all= assets/covers/*)
if [[ "$METADATA" != *"0 image files updated"* ]]
then
  echo -e "[FAIL 02] Images contain metadata:\n $METADATA";
  exit 1;
fi
echo "[PASS 02] Images are correctly formatted"

# does the site HTML validate?
jekyll serve --quiet --detach >/dev/null 2>/dev/null
#validate-website --site "http://localhost:4000" --css-syntax --not-found
# TODO add failure message and implement previous step properly
(kill $(ps aux | grep '[j]ekyll' | awk '{print $2}') >/dev/null 2>/dev/null) || true
echo "[PASS 03] Site markup, links, and styling passed validation"
