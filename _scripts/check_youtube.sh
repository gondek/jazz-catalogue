#!/bin/bash
set -e

# for reference (in comparing to a valid page), the following are removed:
# https://www.youtube.com/watch?v=A9tQHFS83wg
# https://www.youtube.com/playlist?list=PLOzg9gi8fmMa_CEsJ_GaCU53qex4BHfkG

ack-grep -o --nocolor -h --noheading --nobreak "https?:\/\/[\w.]*youtube.com\/[\w?=-]*" _site | while read url; do
  printf "Checking $url: ";

  if [[ $url == *"playlist"* ]]
  then
    (curl -v --silent "$url" 2>&1 | grep -q '<h1 class="pl-header-title"') || (echo "Failed!" && exit 1)
  else
    (curl -v --silent "$url" 2>&1 | grep -q '<span id="eow-title"') || (echo "Failed!" && exit 1)
  fi

  echo "Passed!"
done
