#!/bin/sh
set -e

scriptdir=$(dirname "$0")

cd $scriptdir/..

# Makes only the temporary databases of the hd projects, to learn their sizes before
# running the full 'bin/makedbs.sh'. 'tempdbinfo' stores the temporary database
# ('tempdb') and writes its content per tax id to a CSV file, whose TOTAL row gives the
# number of k-mers. The update that follows in a full run does not change the size much,
# but it moves k-mers between tax ids, so the per-tax-id numbers are not yet final.
projects="hd-enterobact hd-enterobact2 hd-other hd-staph"

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
