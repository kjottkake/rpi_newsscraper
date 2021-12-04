#!/bin/bash

#check to see if initial file exists, if not exit
FILE=./urls_tv2.txts
if test -f "$FILE"; then
	echo "$FILE exists."
else
	echo "ERROR: cannot find $FILE"
fi
