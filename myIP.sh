#!/bin/bash

###########################################################
#
# Written by: Isiah Torres
#
# Course: NTS370
#
# Description: Displays the systems public IP address and
# its local IP address
#
###########################################################

myIP() {

echo "Public IP:"
curl http://icanhazip.com 	# curl is a command that transfers data from a URL.
				# The site next to it only displays our public IP
				# so there is no other options needed.

echo

echo "Local IPs:"

# ip addr shows us our IP and IP6 addresses on the device
# We then pipe the output to grep which searches for "inet", the IP address is prefixed by "inet"
# Then we pipe that output to cut which removes sections or lines for us...
# the -d switch is to set a delimiter "/" and after we split the line up with the delimiter...
# the -f option tells the shell that we want the first field, this takes off the subnetmask.
# We pipe the output yet again to grep, twice, but this time, we tell it to exclude lines with...
# 127.0 and ::1. Lastly we pass the output to awk which is a pattern scanner and ...
# language processor, the '{$1=$1};1' removes any extra spaces. 
ip addr | grep inet | cut -d "/" -f 1 | grep -v 127\.0 | grep -v \:\:1 | awk '{$1=$1};1'

}
