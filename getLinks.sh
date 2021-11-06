#!/bin/bash

file="$PWD/index"
while getopts ":fh" opt; do
  case "${opt}" in
    f)
	    #Writes urls gained from link to a file in the working directory
       wget $2 -O $file
       cat $file | grep -Eo "(http|https)://[a-zA-Z0-9./?=_%:-]*" | sort -u > "$PWD/urlList"
       rm $file
       exit 0
      ;;
     h)
	     #help page for executable
	     echo -e "	-f"
	     echo -e "		used to save urls gained from website in a file within the working directory"
	     echo -e "		usage: -f [URL]"
	;;
    "?")
      exit 1
      ;;
  esac
done

shift $((OPTIND - 1))


if [[ $# -lt 2 ]]; then
	#used to print urls from link in console
	wget $1 -O $file
	cat $file | grep -Eo "(http|https)://[a-zA-Z0-9./?=_%:-]*" | sort -u
	rm $file
fi
