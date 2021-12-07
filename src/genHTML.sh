#!/bin/bash

#loop through files
for ((i=0; i<4; i++))
do
	echo $i
	ARTICLE=./test/$((i+1)).txt
	#echo $ARTICLE
	#for ((j=1; j<5; j++))
	#do
		#echo $ARTICLE
		#LINE=$(sed "${j}q;d" $ARTICLE)
		#echo $LINE
	#done
	URL=$(sed "1q;d" $ARTICLE)
	TITLE=$(sed "2q;d" $ARTICLE)
	IMG=$(sed "3q;d" $ARTICLE)
	DATE=$(sed "4q;d" $ARTICLE)
	echo $URL
	echo $TITLE
	echo $IMG

	touch article$1.html
	echo "
	
        "
done
