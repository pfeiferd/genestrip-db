#!/bin/sh
set -e

scriptdir=$(dirname "$0")

cd $scriptdir/../data/projects

find -type f -exec md5sum "{}" + > md5sums.txt