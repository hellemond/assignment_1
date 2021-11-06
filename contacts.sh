#!/bin/bash

contactsDir="$HOME/Documents/contactsList"

#checks if the contacts dir exists, if not it
if [[ ! -d $contactsDir ]]; then
	mkdir $contactsDir
fi

while getopts ":ar:hd:" opt; do
  case "${opt}" in
    a)
    #prompts user for address, email, their full name, cell number, and home phone
    #file is created with email as name
    #user inputs are appended to file
  	read -p "Enter Address: " address
  	read -p "Enter Email: " email
  	read -p "Enter Full Name: " fullName
  	read -p "Enter Cell number: " cellNumber
  	read -p "Enter Home Number (NA if not applicable): " homePhone
  	FILE="$contactsDir/$email"
  	echo -e $address >> $FILE
  	echo -e $email >> $FILE
  	echo -e $fullName >> $FILE
  	echo -e $cellNumber >> $FILE
	echo -e $homePhone >> $FILE
      ;;
    r)
    #removes contact from contacts directory 
	email=${OPTARG}
	FILE="$contactsDir/$email"
	if [[ ! -f $FILE ]]; then
		echo "$email is not a contact"
	fi

	if [[ -f $FILE ]]; then
		rm $FILE
		echo "$email removed from contacts list"
	fi
      ;;

    h)
    #displays options and their usages
	echo -e "	-a"
	echo -e "	used to add a new contact"
	echo -e "	-r"
	echo -e "	used to remove a contact"
	echo -e "	usage: -r [email]"
	echo -e "	-d"
	echo -e "	uses a contacts email to display a contact"
	echo -e "	usage: -d [email]"
     ;;
    d)
    #takes email as argument and finds file with it then displays file contents
	displayCon=${OPTARG}
	FILE="$contactsDir/$displayCon"
	if [[ -f $FILE ]]; then
		while IFS= read -r line; do
			printf '%s\n' "$line"
		done < "$FILE"
	else
		echo "$displayCon is not a contact"
	fi
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

if [[ $# -lt 1 ]]; then
	echo "you need to provide -a, -r, or -d with an argument"
fi
