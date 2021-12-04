#!/bin/bash



#check to see if initial file exists, if not exit
FILE=./urls_tv2.txt

if test -f "$FILE"; then  		#checks to see if file exists
	echo "$FILE exists."		#if the file exists print OK
	ARTICLECOUNT=$(wc -l < "$FILE")	#saves number of articles into variable
	echo $ARTICLECOUNT		#prints out how many articles there are 
else
	echo "ERROR: cannot find $FILE" #file not found
fi  #end if
