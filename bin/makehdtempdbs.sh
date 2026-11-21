#!/bin/sh
set -e

scriptdir=$(dirname "$0")

cd $scriptdir/..

# Makes only the temporary databases of the hd projects, to learn their sizes before
# running the full 'bin/makedbs.sh'. 'tempdbinfo' stores the temporary database
# ('tempdb') and writes its content per tax id to a CSV file, whose TOTAL row gives the
# number of k-mers. The update that follows in a full run does not change the size much,
# but it moves k-mers between tax ids, so the per-tax-id numbers are not yet final.
# hd-pseudomonas last, as the largest: the others are done should it fail.
projects="hd-entero_n_other hd-enterobact2 hd-pseudomonas"

# First the temporary databases and CSV files of an earlier run go, or 'tempdbinfo' would
# take them as made and not run again. The target 'clean' deletes only the file of the goal
# itself; 'cleanall' would also run down the goal's dependencies.
for project in $projects
do
	for goal in tempdbinfo tempdb
	do
		mvn exec:exec@cleandb -Dname=$project -Dgoal=$goal -Dgs.project.target=clean
	done
done

for project in $projects
do
	mvn exec:exec@db -Dname=$project -Dgoal=tempdbinfo
done

# The sizes of the temporary databases and the k-mer totals from the CSV files.
for project in $projects
do
	ls -l data/projects/$project/db/${project}_tempdb.* 2>/dev/null || true
	grep -h ';TOTAL;' data/projects/$project/csv/${project}_tempdbinfo.csv 2>/dev/null || true
done
