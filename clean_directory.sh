#!/bin/bash

# Basic bash script that, given a base path containing several directories,
# goes through each one of them and deletes all but the last 10 modified files.

# Sample structure
# /my/directory/
#	|_ dir1	
#		|_ (many files and directories)	
#	|_ dir2
#		|_ (many files and directories)
#	|_ dir3	
#		|_ (many files and directories)

cd /my/directory/

# find . -maxdepth 2 -name *.zip -print0 | xargs -0 rm	#Ignore this line

DIR_PROD=$(ls /my/directory/ | grep -v env)		#Exclude env directory, modify accordingly

for I in ${DIR_PROD[@]}					#For every directory within /my/directory
do
	DEPB=$(echo "$(ls -t $I | grep -vi unpack | tail -n +11)")	#Everything but the last 10 files/directories and unpack
	for K in ${DEPB[@]}				#For everything stored above
	do
		echo "Deleting $(pwd)/$I/$K..."
		rm -rf "$I/$K"				#Delete it
	done
done
