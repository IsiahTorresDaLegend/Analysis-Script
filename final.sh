#!/bin/bash

###########################################################
#
# Written by: Isiah Torres
#
# Course: NTS370
#
# Description: Performs file analysis, nmap Web server
# scans, and displays the device's IP address. The user has
# a menu to select which operations to perform.
#
###########################################################

# Include the functions from the following bash scripts.
source passAnalysis.sh
source fileAnalysis.sh
source nmapWebVer.sh
source myIP.sh

while [[ $choice != 'quit' ]]	# while loop to cuntinue program until user enters 'quit' ($choice)
do 	# While the above condition is not met, perform these actions. 
	# Display options for user to choose from.
	echo
	echo -e "1) /etc/passwd file analysis.\n"
	echo -e "2) Search file for specific information (e.g. *.log).\n"
	echo -e "3) Perform nmap scan to see version of software running on port 80.\n"
	echo -e "4) View current public and local IP addresses.\n"
	echo -e "Enter 'quit' to exit program.\n"
	echo "Select an operation to perform (1-4): "
	read choice	# Get choice from user input.

	case $choice in	# Case statement to perform various operations depending on user's choice.
		1) 	# if user entered '1'...
			passAnalysis;;	# run this function from passAnalysis.sh
		2)	# if user entered '2'...
			fileAnalysis;;	# run this function from fileAnalysis.sh
		3)	# if user entered '3'...
			nmapWebVer;;	# run this function from nmapWebVer.sh
		4)	# if user entered '4'...
			myIP;;		# run this function from myIP.sh
		quit)	# if user entered 'quit'...
			exit 0;;	# Exit program with exit code 0 (normally)
		*)	# * catches all other cases... 
		echo -e "Invalid choice\n";;	# Give user a warning
	esac		# End case statement.
done	# End while loop. 
