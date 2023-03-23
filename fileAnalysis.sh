#!/bin/bash

###########################################################
#
# Written by: Isiah Torres
#
# Course: NTS370
#
# Description: Opens a logfile and parses out specific
# information to user.
#
###########################################################

fileAnalysis () {	# Create a function: nameOfFunction () { definition }

# This will be the file we operate on. -e allows special backslash escape characters
echo -e "Enter a file to analyze (e.g. /var/log/yum.log):\n"
read targetFile

# Tests whether the file given exists or not, if it does not, restart function.
# if the command on the left of && is successful, then perform the command on the right.
# ! not -e exist
[ ! -e $targetFile ] && echo -e "File does not exist!\n" && fileAnalysis 

# File that will store the results.
echo -e "Enter an output file to store results:\n"
read outfile

# What elements of the file were looking for.
echo -e "Enter a pattern to search for (supports extended regular expressions):\n "
echo -e "(Can look at multiple patterns by placing '|' between patterns e.g. blue|green)\n"
read pattern

# Uses sudo incase we need elevated file permissions to rea, as is the case with some logs.
# grep -i ignores whether the pattern is uppercase or lowercase...
# we use grep to search the provided pattern on the provided file, then send the output to...
# the provided output file. -E allows pattern to be interpreted as an extended regular expression.
# Allows users to enter more than one pattern at a time with |.
sudo grep -Ei "$pattern" $targetFile > $outfile

while [ ! -s $outfile ]	# This loop prevents having to restart function if pattern was not found.
			# If grep cannot find the pattern specified, the output would be empty.
			# Thus, if the output file has a size of 0, then we will redo the... 
			# following commands. ! -s $outfile means the file is not greater than 0. 
do	
	echo -e "\nPattern was not found!\n"	# Tell the user what went wrong, grep should...
						# supply an error if the file does not exist.
						
	echo -e "Enter a pattern to search for:\n"	# Get another pattern
	read pattern
	sudo grep -Ei "$pattern" $targetFile > $outfile	# Try operation again
done

more $outfile 	# If the above loop escaped, means the first operations were successful...
		# use more to display results to screen one page at a time.

echo -e "\nFilter this file further (e.g. y or n)? "	# Provide more exact results if user needs.
read answer	# If answer is 'n' were done and function ends. 

while [ $answer != 'n' ]	# If user wants to filter out results even more...
do 
	echo -e "\nEnter another pattern to search for: "
	read pattern
	sudo grep -Ei "$pattern" $outfile > tmp_results	# Perform grep operation on results
							# This filters the results even more...
							# then since the same file cannot be...
							# the input and output with grep...
							# we send results to a temporary file.
							
	if [ ! -s tmp_results ]				# instead of overwritting the results...
							# we test whether the previous grep...
							# was successful first, as a failed...
							# grep would have an empty output. 
	then 
		echo -e "\nPattern was not found!"	# if unsuccessful, restart loop...
							# which asks for a different pattern.
		continue				# continue skips over everything else...
							# and goes to the next iteration of the...
							# loop.
	else
		mv tmp_results $outfile			# if successful, overwrite $output file...
							# with temporary file. 
		more $outfile				# Display results one page at a time.

		echo -e "\nFilter this file further (e.g. y or n)? "	# ask user if they would...
									# like to filter even more.
		read answer
	fi	# End if statement
done	# End while loop

echo -e "To view results again, open $outfile.\n"	# Show user where to find results.
}
