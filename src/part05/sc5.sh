#!/bin/bash

NC='\033[0m'
RED='\033[31m'
BLUE='\033[34m'

START=$(date +%s%N)

if [ $# != 1 ]
then
	echo -e "${RED}ERROR:${NC}: not enough argument"
elif [ ${1: -1} != "/" ]
then
	echo -e "${RED}ERROR:${NC}: wrong argument"
else
	number_folders=$(find $1 -type d | wc -l)
	top_five_folders=$(du -Sh $1 | sort -rh | head -5 | cat -n | awk '{print $1" - "$3", "$2}')
	total_number_of_files=$(find $1 -type f | wc -l)
	conf=$(find $1 -type f -name "*.conf" | wc -l)
	txt=$(find $1 -type f  -name "*.txt" | wc -l)
	exe=$(find $1 -type f -executable -exec du -h {} + | wc -l | awk '{print $1}')
	log=$(find $1 -type f -name "*.log" | wc -l )
	archive=$(find $1 -regex ".*\(tar\zip\lgz\lrar\)" | wc -l)
	link=$(find $1 -type l | wc -l)
	files_top_ten=$(find $1 -type f -exec du -h {} + | sort -rh | head -10 | cat -n)
	executable_files_top_ten=$(find $1 -type f -exec du -Sh {} + | sort -rh | head -10 | cat -n | awk '{print $1" - "$3", "$2}')

	echo -e "${BLUE}Total number of folders, including subfolders${NC}: = $number_folders"
	echo -e "${BLUE}Top five folders of max size arranged in desc order${NC}:"
	echo "$top_five_folders"
	echo -e "${BLUE}Total number of files${NC}: = $total_number_of_files"
	echo -e "${BLUE}Display count files of .conf${NC}: = $conf"
	echo -e "${BLUE}Display count files of .txt${NC}: = $txt"
	echo -e "${BLUE}Display count files of .exec${NC}: = $exe"
	echo -e "${BLUE}Display count files of .log${NC}: = $log"
	echo -e "${BLUE}Display count files of .tar/zip/lgz/lrar${NC}: = $archive"
	echo -e "${BLUE}Display count link files${NC}: = $link"
	echo -e "${BLUE}Top files in catalog${NC}:"
	echo "$files_top_ten"
	echo -e "${BLUE}Top executable files${NC}:"
	echo "$executable_files_top_ten"
	END=$(date +%s%N)
	DIFF=$((( $END - $START )/1000000))
	echo -e "${BLUE}Script exec time${NC} = $DIFF"
fi