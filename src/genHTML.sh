#!/bin/bash

#loop through files
for ((i=0; i<4; i++))
do
	echo $i
	ARTICLE=./test/$((i+1)).txt
	#echo $ARTICLE
	for ((j=1; j<5; j++))
	do
		#echo $ARTICLE
		LINE=$(sed "${j}q;d" $ARTICLE)
		echo $LINE
	done
done
