#!/bin/bash
set -e
cd `dirname $0`/../

./_scripts/make-thumbnails.sh
echo "Thumbnails Generated!"

jekyll build --quiet
echo "Jekyll Site Built!"

if [[ \"`git status --porcelain`\" != \"\" ]]; then
  echo "Working directory is not clean: Stage and commit changes!"
  exit 1
fi

git checkout gh-pages
cp -r _site/* .
git add -A
MSG=$(git log --format=%B -n 1 HEAD)
git commit -m "$MSG"
echo -e "Site files commited! Pushing: ....\n\n"

git push origin gh-pages
git checkout master
git clean -fd

echo -e "\n\nDone!\n\n"
