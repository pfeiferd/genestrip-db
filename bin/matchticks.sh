#!/bin/sh
set -e

scriptdir=$(dirname "$0")

cd $scriptdir/..

if [ -z "$1" ]
  then
	goal=match
  else
  	goal=$1
fi

mvn exec:exec@match -Dfqmap=./data/fastq/ticks.txt -Dname=borrelia -Dgoal=$goal
mvn exec:exec@match -Dfqmap=./data/fastq/ticks.txt -Dname=borrelia_plasmid -Dgoal=$goal
mvn exec:exec@match -Dfqmap=./data/fastq/ticks.txt -Dname=tick-borne -Dgoal=$goal
