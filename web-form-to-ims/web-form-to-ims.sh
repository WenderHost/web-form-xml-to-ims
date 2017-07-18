#!/usr/bin/env bash

source ~/scripts/config.sh

SITELIST=($(ls -lh $SITESTORE | awk '{print $9}'))

XMLFILES=public/wp-content/uploads/xml_test

for SITE in ${SITELIST[@]}; do
	if ! $(cd $SITESTORE/$SITE/$XMLFILES 2>/dev/null); then
		printf "\e[33m\e[1mNOTE:\e[0m $SITE - no XML form entries found. Continuing...\n"
		continue
	fi

	TOTALENTRIES=$(ls -F $SITESTORE/$SITE/$XMLFILES | grep -v / | wc -l)
	printf "\e[32m\e[1mSUCCESS:\e[0m $SITE has $TOTALENTRIES XML form entries.\n"
	cd $SITESTORE/$SITE/$XMLFILES
	FILELIST=($(ls --hide=.htaccess -lh . | awk '{print $9}'))
	#for FILE in ${FILELIST[@]}; do
	#	printf "Found $FILE\n"
	#done
done