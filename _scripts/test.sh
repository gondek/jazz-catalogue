#!/bin/bash
set -e
cd `dirname $0`/../

# does the site build?
./_scripts/build.sh
