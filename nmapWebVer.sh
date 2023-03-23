#!/bin/bash

###########################################################
#
# Written by Isiah Torres
#
# Course: NTS370
#
# Description: Uses nmap to connect to a remote web server
# to determine the version of software on port 80
#
###########################################################

nmapWebVer() {	#create a function.

# Function definition
echo -e "Enter a filename to save the results to:\n"
read results

# Give user instructions.
echo -e "Target can be a URL/hostnames, IP addresses, or a networks.\n"
echo -e "(e.g. scanme.nmap.org, 192.168.0.1; 10.0.0-255.1-254)\n"
echo -e "Provide target(s):\n"
read targets

# Let user know program is working.
echo -e "Starting scan...\n"

# nmap is used as a Network exploiter tool and security / port scanner.
# -p is for port scans followed by the port range. Port 80 is used for HTTP services.
# -sV enables services/version detection. Then we pass the targets supplied.
# Then send nmap's results to a file provided by user. 
nmap -p80 -sV $targets > $results

more $results	# Display results one page at a time.

echo -e "Scan results can be viewed at $results.\n"	# Remind user where results are stored.

}

