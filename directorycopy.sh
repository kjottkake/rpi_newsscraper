#!/bin/bash

#get tv2 news and write into tv2nyheter file
curl  https://www.tv2.no/nyheter > tv2nyheter.html
echo "Curled tv2.no/nyheter"

#get articles elements from tv2nyheter file and write into tv2articles
opentag='<article class=\"article column large-6 small-6 article--nyheter\">' #defining open tag search
closetag='<\/article>'							      #defining close tag to search
sed -n "/$opentag/,/$closetag/p" tv2nyheter.html > tv2articles.html          #-n argument to not print anything
echo "Collected tv2 news articles"

#get urls and make into new list
cat tv2articles.html | grep 'href' > tv2articleUrls.html
echo "Collected tv2 Article Urls"

#current date method
CURRENTDATE=$(date +"%Y-%m-%d")
#create new directory
mkdir ./src/articles/$CURRENTDATE
echo "Created new directory ./src/articles/" + $CURRENTDATE

#gets urls from article urls
grep -oP '/nyheter/\K.*' tv2articleUrls.html | sed 's/\/\">//g' > urls_tv2.txt  
echo "Created list of urls"

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
		WORKINGDIR="./src/articles/${CURRENTDATE}"
                ARTICLE=$(sed "${i}q;d" $FILE)                                  #set ARTICLE variable
                curl $URL+$ARTICLE > $WORKINGDIR/$ARTICLE.html    #get urls into separate html files      
		#titleOpentag='<h1 itemprop="headline" class="articleheader__title">'
        	titleOpentag='<h1'
		titleClosetag='</h1>'
		imagetag='<figure>'
		imageclosetag='<\/figure>'
		#createfile
		touch ./src/articles/$CURRENTDATE/article$i.txt
		#get url
		echo $URL$ARTICLE > ./src/articles/$CURRENTDATE/article$i.txt
		#get the title
		grep $titleOpentag ./src/articles/$CURRENTDATE/$ARTICLE.html | sed -e 's/<[^>]*>//g' >> ./src/articles/$CURRENTDATE/article$i.txt
		#get img
		sed -n "/$imagetag/,/$imageclosetag/p" ./src/articles/$CURRENTDATE/$ARTICLE.html | grep -oP 'data-src=\".*?\"' | grep -Po '="\K[^"]+' > ./src/articles/$CURRENTDATE/images$i.txt
		sed '1q;d' ./src/articles/$CURRENTDATE/images$i.txt >> ./src/articles/$CURRENTDATE/article$i.txt
 		#get date
		echo $CURRENTDATE >> ./src/articles/$CURRENTDATE/article$i.txt
	done
else
        echo "ERROR: cannot find $FILE" #file not found
fi  #end if


