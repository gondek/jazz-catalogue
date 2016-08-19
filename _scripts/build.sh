#!/bin/bash
set -e
cd `dirname $0`/../

jekyll build --quiet
echo "Jekyll Site Built!"
