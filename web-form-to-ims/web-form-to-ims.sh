#!/usr/bin/env bash

DIVIDER="----------------------------------------"
echo "$DIVIDER"$'\n'"Initiating XML transfer..."

# by default, we won't delete the files after FTP
DELETE=false

# process arguments
while getopts ":d" opt; do
	case $opt in
		d)
			# delete files after FTP
			printf "INFO: \e[33m\e[1mDELETE\e[0m files after FTP is ON.\n" >&2
			DELETE=true
			;;
		\?)
			echo "Invalid option: -$OPTARG" >&2
			exit 1
			;;
	esac
done

# Get current directory (not bulletproof, source: http://www.ostricher.com/2014/10/the-right-way-to-get-the-directory-of-a-bash-script/)
PWD="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Check for `config.sh`
if ! $(source $PWD/../config.sh 2>/dev/null); then
	echo 'ERROR: No configuration found! Please setup `config.sh` with the proper vars defined.'
	exit
fi

source $PWD/../config.sh

SITELIST=($(ls -lh $SITESTORE | awk '{print $9}'))

for SITE in ${SITELIST[@]}; do
	# Check for XML form entries
	if ! $(cd $SITESTORE/$SITE/$XMLFILES 2>/dev/null); then
		printf "\e[33m\e[1mNOTE:\e[0m $SITE - no XML form entries found. Continuing...\n"
		continue
	fi

	TOTALENTRIES=$(ls -F $SITESTORE/$SITE/$XMLFILES | grep -v / | wc -l)
	# continue if 0 XML entries found
	if [[ "$TOTALENTRIES" -eq 0 ]]; then
		printf "\e[33m\e[1mNOTE:\e[0m $SITE has $TOTALENTRIES XML entries. Continuing...\n"
		continue
	fi

	printf "\e[32m\e[1mSUCCESS:\e[0m $SITE has $TOTALENTRIES XML form entries.\n"
	cd $SITESTORE/$SITE/$XMLFILES
	FILELIST=($(ls --hide=.htaccess -lh . | awk '{print $9}'))

	PUTCMD=''

	for FILE in ${FILELIST[@]}; do
		PUTCMD+="put $FILE"$'\n'
	done

	printf "Initiating FTP..."$'\n'

	lftp -u $FTPSUSER,$FTPSPASS $FTPSSERVER << EOF
$PUTCMD
bye
EOF

	printf "FTP Complete"$'\n'

	# delete files after FTP
	if [ "$DELETE" = true ] ; then
		for FILE in ${FILELIST[@]}; do
			unlink $FILE
		done
	fi

done