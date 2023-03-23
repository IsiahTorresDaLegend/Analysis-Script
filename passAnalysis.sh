#!/bin/bash

###########################################################
#
# Written by: Isiah Torres
#
# Course: NTS370
#
# Description: Performs analysis of the /etc/passwd file
# and parses out certain information.
#
###########################################################

passAnalysis () {	# Create a function

# Function definition:
# Display options to user. 
echo -e "Select which data you would like to view from /etc/passwd...\n"
echo -e "1) Login, uid, gid, info, home, shell\n"
echo -e "2) Login, uid, gid, home, shell\n"
echo -e "3) Login, home, shell\n"
echo -e "4) Search for something specific\n"
echo "Enter a number (1-4): "
read choice	# Get choice from user input.

case $choice in	# Case statement for different actions based on user's choice. 
	1)	# gawk is like awk, which does pattern scanning and language processing
		# We tell gawk what the field delimiter is with -F ':', then tell it what...
		# fields we want printed ($1 is first field, $3 is third field, etc, etc).
		# then we specify which file were using as input (/etc/passwd). 
		# Then we send the results to a file. 
		gawk -F ':' '{print $1, $3, $4, $5, $6, $7}' /etc/passwd > passwd-parsed.txt
		sort -d passwd-parsed.txt &>/dev/null	# sort the file alphebetically (-d)...
							# we send the stdout and stderr to ...
							# /dev/null so the operation is not...
							# displayed on screen. 
		more passwd-parsed.txt;;		# Use more to display results incase...
							# /etc/passwd is large.
	2)
		gawk -F ':' '{print $1, $3, $4, $6, $7}' /etc/passwd > passwd-parsed.txt
		sort -d passwd-parsed.txt &>/dev/null	# 2) is the same as 1) but with less fields
		more passwd-parsed.txt;;
	3)
		gawk -F ':' '{print $1, $6, $7}' /etc/passwd > passwd-parsed.txt
		sort -d passwd-parsed.txt &>/dev/null	# 3) is also the same but with just...
							# Login, home directory, and shell.
		more passwd-parsed.txt;;
	4)
		echo -e "Enter what element you are looking for:\n"	# Different instructions
		read findElement
	 	grep $findElement /etc/passwd;;	# Search /etc/passwd file directly with grep.
	*)	# catch everything else that is not a valid choice.
		echo -e "Invalid Choice\n";;
esac	# End of case statement.
}
