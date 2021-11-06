#!/bin/bash

while getopts ":n:h" opt; do
  case "${opt}" in
    n)
	#prints file line by line with numbers
	FILE="$PWD/${OPTARG}"    
      n=1
	while read line; do
	echo "$n. $line"
	n=$((n+1))
	done < $FILE
	exit 0
        ;;
     h)
	     #help page for executable
	     echo "	Prints contents of files line by line"
	     echo "	-n "
	     echo "		Prints contents of files line by line with line numbers"
	;;
      :)
      	echo "Error: -${OPTARG} requires an argument"
      	exit 1
      	;;
    "?")
      exit 1
      ;;
  esac
done

shift $((OPTIND - 1))

if [[ $# -lt 2 ]]; then
	#prints file contents line by line without line numbers
	FILE="$PWD/$1"
        while read line; do
        echo "$line"
        done < $FILE
	exit 0
fi
