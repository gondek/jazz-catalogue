#!/bin/bash
set -e
cd `dirname $0`/../

./_scripts/build.sh

if [[ \"`git status --porcelain`\" != \"\" ]]; then
  echo "Working directory is not clean: Stage and commit changes!"
  exit 1
fi

MSG=$(git log --format=%B -n 1 HEAD)
echo "Using message: $MSG"
git checkout gh-pages
git pull
echo "Copying generate files to root"
cp -r _site/* .
echo "Adding all files and committing"
git add -A
git commit -m "$MSG"
echo -e "Site files commited! Pushing: ....\n\n"

git push origin gh-pages
git checkout master
git clean -fd

echo -e "\n\nDone!\n\n"
