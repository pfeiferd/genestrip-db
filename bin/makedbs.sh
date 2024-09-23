#!/bin/sh
set -e

scriptdir=$(dirname "$0")

cd $scriptdir/..

if [ -z "$1" ]
  then
	goal=genall
  else
  	goal=$1
fi


mvn exec:exec@db -Dname=human_virus2 -Dgoal=$goal
mvn exec:exec@db -Dname=babesia -Dgoal=$goal
mvn exec:exec@db -Dname=chronicb-rna -Dgoal=$goal
mvn exec:exec@db -Dname=protozoa -Dgoal=$goal
mvn exec:exec@db -Dname=vineyard -Dgoal=$goal
mvn exec:exec@db -Dname=parasites -Dgoal=$goal
mvn exec:exec@db -Dname=borrelia -Dgoal=$goal
mvn exec:exec@db -Dname=borrelia_plasmid -Dgoal=$goal
mvn exec:exec@db -Dname=chronicb -Dgoal=$goal
mvn exec:exec@db -Dname=plasmopara -Dgoal=$goal

