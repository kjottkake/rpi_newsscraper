#!/bin/bash

#get tv2 news and write into tv2nyheter file
curl  https://www.tv2.no/nyheter  > tv2nyheter.html

#get articles elements from tv2nyheter file and write into tv2articles
opentag='<article class=\"article column large-6 small-6 article--nyheter\">'
closetag='<\/article>'
sed -n "/$opentag/,/$closetag/p" tv2nyheter.html > tv2articles.html

#get urls and make into new list
cat tv2articles.html | grep 'href' > tv2articleUrls.html


CURRENTDATE=$(date +"%Y-%m-%d")
#create new directory
mkdir ./src/articles/$CURRENTDATE
#gets urls from article urls
grep -oP '/nyheter/\K.*' tv2articleUrls.html | sed 's/\/\">//g' > urls_tv2.txt  

#check to see if initial file exists, if not exit
FILE=./urls_tv2.txt
URL="https://www.tv2.no/a/"
if test -f "$FILE"; then                #checks to see if file exists
        echo "$FILE exists."            #if the file exists print OK
        ARTICLECOUNT=$(wc -l < "$FILE") #saves number of articles into variable
        echo $ARTICLECOUNT              #prints out how many articles there are
        #here is where the logic starts
        #for each article
        for ((i=0; i<=$ARTICLECOUNT; i++))
        do
                ARTICLE=$(sed "${i}q;d" $FILE)
                curl $URL+$ARTICLE > ./src/articles/$CURRENTDATE/$ARTICLE.html
		titleOpentag='<h1 itemprop="headline" class="articleheader__title">'
        	titleClosetag='</h1>'
		#get the title
		
	done
        #get the title 
        #get the image 
else
        echo "ERROR: cannot find $FILE" #file not found
fi  #end if


