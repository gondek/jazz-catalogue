#!/bin/bash
set -e

cd `dirname $0`/../

# does the site build?
echo "[TASK] Building site ----------------------------------------------------"
# change the config so HTML validation checks against local links
sed -i "s,url: \"http://jazz.gondek.ca\",url: \"\"," _config.yml
./_scripts/build.sh >/dev/null
git checkout _config.yml
echo "[PASS] Site built correctly! --------------------------------------------"
echo

# are all album covers 300x300 and contain no metadata?
echo "[TASK] Checking images --------------------------------------------------"
for f in assets/covers/*; do
  SIZE=$(exiftool $f | grep "Image Size")
  if [[ "$SIZE" != *"300x300"* ]]
  then
    echo -e "[FAIL] $f has the wrong dimensions:\n $SIZE";
    exit 1;
  fi
done
METADATA=$(exiftool -all= assets/covers/*)
if [[ "$METADATA" != *"0 image files updated"* ]]
then
  echo -e "[FAIL] Images contain metadata:\n $METADATA";
  exit 1;
fi
echo "[PASS] Images are correctly formatted -----------------------------------"
echo

# does the site HTML validate?
echo "[TASK] Checking HTML ----------------------------------------------------"
htmlproofer --assume-extension --check-html --http-status-ignore "403" --url-ignore "/.*https:\/\/(jekyllrb)|(pages\.github).com.*/" ./_site
echo "[PASS] Site markup and links passed validation --------------------------"
echo
