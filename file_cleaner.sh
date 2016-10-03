#!/bin/bash

# Small bash script that, given a base directory
# containing multiple files with different naming formats, keeps the last 10 of each type.

# Sample structure
# /var/packages/myproject/
#		|_ thisfile_v1-37434.zip
#		|_ thisfile_v1-65632.zip
#		|_ thisfile_v1-10383.zip
#		|_ anotherfilename_v1-9248324923.zip
#		|_ anotherfilename_v1-02029382.zip

cd /var/packages/$1

echo ""
echo "---------- DIRECTORY: $(pwd) ----------"

FILES=$(ls | grep _v)	#Ignore files that do not contain _v string
for I in $FILES		#Discard version number (_v onwards) from file names and store in AF
do
        I=$(echo $I | awk -F "_v" '{print $1}')
        AF+=($I)	
done
UNIQ=($(printf "%s \n" "${AF[@]}" | sort -u))	#Discard duplicate names and store unique names in UNIQ

echo "---------- FILES: ${UNIQ[@]} "

for K in ${UNIQ[@]}
do
        for J in $FILES
        do
                if [ "$K" != "$TMP" ] ; then	#Check that the name has not been processed
                P=$(echo "$(ls -t | grep $K'_v' | tail -n +11)")	#List all files matching $K_v except for the last 10 modified
		ARRDEL+=($P)
                TMP=$K	#K has already been processes and is assigned to TMP so that it is not listed again
                fi
        done
done

for D in "${ARRDEL[@]}"
do
	echo "--------- DELETING: $D"
	rm -f "$D"
done
echo ""
