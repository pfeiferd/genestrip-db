#!/bin/sh
set -e

scriptdir=$(dirname "$0")

cd $scriptdir/..

# By default each project is made with 'ftgenall' (the k-mer matching database, the
# filtering database and the FT database) followed by the SVG taxonomy trees of the
# database contents: 'svgtaxtree' for the plain and 'ftsvgtaxtree' for the FT database.
# Goals given as arguments replace the whole list.
if [ -z "$1" ]
  then
	goals="ftgenall svgtaxtree ftsvgtaxtree"
	md5sums=yes
  else
  	goals="$@"
fi

makedb() {
	for goal in $goals
	do
		mvn exec:exec@db -Dname=$1 -Dgoal=$goal
	done
}

makedb babesia
makedb borrelia
makedb fungal_infect
makedb human_virus2
makedb parasites
makedb plasmopara
makedb protozoa
makedb protozoa_rna
makedb tick-borne
makedb tick-borne_rna
makedb vineyard

# The checksums of the generated files, as needed by 'bin/upload.sh', but only after a
# default run: a run with goals of its own need not leave the databases in a state
# worth uploading. Computing them here rather than at upload time is no extra work,
# since the upload keeps them as they are while no file is newer.
if [ -n "$md5sums" ]
  then
	sh bin/md5.sh
fi
