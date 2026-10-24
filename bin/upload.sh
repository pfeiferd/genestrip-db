#!/bin/sh
set -e

# Transfers everything below 'data/projects' to the mirror for the official download,
# including the folder 'projects' itself. Nothing is packed or copied beforehand:
# rsync reads the files in place and sends them straight to the mirror, so neither
# machine needs room for a second copy of a database.
#
# Usage: sh bin/upload.sh <target> [<password>]
#
#   <target>    The mirror along with the path that the folder 'projects' goes into,
#               e.g. 'user@genestrip.it.hs-heilbronn.de:/var/www/files/data/' for a
#               transfer via ssh, or 'host::modul/data/' (likewise
#               'rsync://host/modul/data/') for an rsync daemon.
#   <password>  Optional. May also be given as the environment variable
#               GS_UPLOAD_PASSWORD, which keeps it out of the process list.
#               An rsync daemon takes it as is, a transfer via ssh requires
#               'sshpass' for it. An ssh key is the better way: then the password
#               can be omitted entirely.
#
# The transfer may be interrupted and repeated: rsync then sends only what is
# missing or has changed since.

scriptdir=$(dirname "$0")

cd $scriptdir/..

target=$1
password=${2:-$GS_UPLOAD_PASSWORD}

if [ -z "$target" ]
  then
	echo "Usage: sh bin/upload.sh <target> [<password>]" >&2
	echo "  e.g. sh bin/upload.sh user@host:/var/www/files/data/" >&2
	exit 1
fi

# The checksums are part of the upload, so they have to cover the current state: they
# are rewritten where they are missing, where a file is newer than they are, or where
# the number of files no longer matches theirs - the last one because a file that was
# deleted leaves them with an entry but makes nothing newer than them.
files=$(find data/projects -type f ! -name md5sums.txt | wc -l)

if [ ! -f data/projects/md5sums.txt ] \
		|| [ -n "$(find data/projects -type f ! -name md5sums.txt -newer data/projects/md5sums.txt -print -quit)" ] \
		|| [ "$files" != "$(wc -l < data/projects/md5sums.txt)" ]
  then
	echo "Generating data/projects/md5sums.txt..."
	sh bin/md5.sh
  else
	echo "Keeping data/projects/md5sums.txt, it covers the current files."
fi

# A progress bar makes sense on a terminal only; a log gets the summary instead.
if [ -t 1 ]
  then
	info=--info=progress2
  else
	info=--info=stats2
fi

# '--inplace' writes into the target file directly, so the mirror does not need room
# for a temporary second copy of a database. A file is hence incomplete on the mirror
# while it is being transferred.
# There is no '-z': the databases and indexes are compressed files already.
# 'data/projects' is given without a trailing slash, so the folder itself is
# transferred instead of just its content.
set -- -rt --inplace --human-readable $info data/projects "$target"

case "$target" in
	*::*|rsync://*)
		RSYNC_PASSWORD=$password
		export RSYNC_PASSWORD
		rsync "$@"
		;;
	*)
		if [ -n "$password" ]
		  then
			sshpass -p "$password" rsync "$@"
		  else
			rsync "$@"
		fi
		;;
esac
