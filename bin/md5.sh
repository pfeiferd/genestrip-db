#!/bin/sh
set -e

scriptdir=$(dirname "$0")

cd $scriptdir/../data/projects

# 'md5sums.txt' itself is left out: it is still being written while find runs,
# so its own entry could never match it.
find -type f ! -name md5sums.txt -exec md5sum "{}" + > md5sums.txt
