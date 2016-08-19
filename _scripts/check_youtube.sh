#!/bin/bash
set -e

check_playlist () {
  curl -v --silent "$1" 2>&1 | grep -q '<h1 class="pl-header-title"'
}

check_video () {
  curl -v --silent "$1" 2>&1 | grep -q 'movie_player'
}

# verify that the following test URLS fail
check_video "https://www.youtube.com/watch?v=A9tQHFS83wg" && (echo "Integrity test 1 failed!" && exit 1)
check_playlist "https://www.youtube.com/playlist?list=PLOzg9gi8fmMa_CEsJ_GaCU53qex4BHfkG" && (echo "Integrity test 2 failed!" && exit 1)
check_video "https://www.youtube.com/watch?v=mAPMJWpeY3U" && (echo "Integrity test 3 failed!" && exit 1)

# verify the actual urls
EXIT_CODE=0
ack-grep -o --nocolor -h --noheading --nobreak "https?:\/\/[\w.]*youtube.com\/[\w?=-]*" _site | while read url; do
  if [[ $url == *"playlist"* ]]
  then
    (check_playlist "$url" && echo "  > Pass: $url")  || (echo "  > Fail: $url" && EXIT_CODE=1)
  else
    (check_video "$url" && echo "  > Pass: $url") || (echo "  > Fail: $url" && EXIT_CODE=1)
  fi
done
exit $EXIT_CODE
