#!/bin/sh
set -e

scriptdir=$(dirname "$0")

cd $scriptdir/..

# Deletes the generated files of all projects: the databases, the filtering databases,
# the *k*-mer indexes, a temporary database left over from an interrupted run, the info
# CSVs and the SVG taxonomy trees - everything 'bin/makedbs.sh' produces. Genestrip
# deletes them itself, through the target 'cleanall' on the goals that script makes, so
# exactly the files of those goals are removed. What was downloaded from the RefSeq and
# from Genbank is kept, as the recursive deletion stops at the download goals; a rebuild
# can hence start from them.
#
# Usage: sh bin/cleardb.sh [<target>]
#
#   <target>  'cleanall' by default. 'cleantotal' deletes the downloads as well, so the
#             next build fetches them anew. ('clean' is of little use here: 'ftgenall'
#             owns no file of its own, hence nothing of it would be deleted.)

if [ -z "$1" ]
  then
	target=cleanall
  else
	target=$1
fi

goals="ftgenall svgtaxtree ftsvgtaxtree"

cleardb() {
	for goal in $goals
	do
		mvn exec:exec@cleandb -Dname=$1 -Dgoal=$goal -Dgs.project.target=$target
	done
}

cleardb babesia
cleardb borrelia
cleardb fungal_infect
cleardb human_virus2
cleardb parasites
cleardb plasmopara
cleardb protozoa
cleardb protozoa_rna
cleardb tick-borne
cleardb tick-borne_rna
cleardb vineyard

# The checksums describe files that are gone now.
rm -f data/projects/md5sums.txt
