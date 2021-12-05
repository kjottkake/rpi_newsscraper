#!/bin/bash

#loop through files
for ((i=0; i <=3; i++))
do
	ARTICLE=./test/$((i+1)).txt
	echo $ARTICLE
done
