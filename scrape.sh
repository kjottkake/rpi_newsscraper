#!/bin/bash

#get tv2 news and write into tv2nyheter file
curl  https://www.tv2.no/nyheter > tv2nyheter.html
echo "Curled tv2.no/nyheter"

#get articles elements from tv2nyheter file and write into tv2articles
opentag='<article class=\"article column large-6 small-6 article--nyheter\">' #defining open tag search.
closetag='<\/article>'							      						  #defining close tag to search.
sed -n "/$opentag/,/$closetag/p" tv2nyheter.html > tv2articles.html           #searches for opentag and close tag from file and outputs into new file.
echo "Collected tv2 news articles"

#get urls and make into new list
cat tv2articles.html | grep 'href' > tv2articleUrls.html	#gets all href items from file and outputs into new html file.
echo "Collected tv2 Article Urls"

#current date method
CURRENTDATE=$(date +"%Y-%m-%d")							#defines current date variable.
#create new directory
mkdir ./src/articles/$CURRENTDATE						#create a new directory based on current date.
echo "Created new directory ./src/articles/" + $CURRENTDATE

#gets urls from article urls
grep -oP '/nyheter/\K.*' tv2articleUrls.html | sed 's/\/\">//g' > urls_tv2.txt  #gets all news urlcodes from tv2.no/nyheter and outputs them into new file.
echo "Created list of urls"

#check to see if initial file exists, if not exit
FILE=./urls_tv2.txt
URL="https://www.tv2.no/a/"
if test -f "$FILE"; then                #checks to see if file exists
        echo "$FILE exists."            #if the file exists print OK
        ARTICLECOUNT=$(wc -l < "$FILE") #saves number of articles into variable
        echo $ARTICLECOUNT              #prints out how many articles there are
        #for each article
        for ((i=0; i<=$ARTICLECOUNT; i++))
        do
		WORKINGDIR="./src/articles/${CURRENTDATE}"				  #define working directory variable
                ARTICLE=$(sed "${i}q;d" $FILE)                    #defines variable that gets the tv2 article codes from file, line by line via each iteration
                curl $URL+$ARTICLE > $WORKINGDIR/$ARTICLE.html    #gets separate copies of individual news article pages   
        titleOpentag='<h1'										#defines opening html title tag variable
		titleClosetag='</h1>'									#defines closing html title tag variable
		imagetag='<figure>'										#defines opening image tag variable
		imageclosetag='<\/figure>'								#defines closing image tag variable
		#createfile
		touch ./src/articles/$CURRENTDATE/article$i.txt			#creates new article 
		#get url
		echo $URL$ARTICLE > $WORKINGDIR/article$i.txt	       #outputs URL of article as first line of new file
		#get the title
		grep $titleOpentag $WORKINGDIR/$ARTICLE.html | sed -e 's/<[^>]*>//g' >> $WORKINGDIR/article$i.txt   #outputs title of article as second line of new file
		#get img
		sed -n "/$imagetag/,/$imageclosetag/p" $WORKINGDIR/$ARTICLE.html | grep -oP 'data-src=\".*?\"' | grep -Po '="\K[^"]+' > ./src/articles/$CURRENTDATE/images$i.txt #creates new image file and outputs all img elements into image file
		sed '1q;d' $WORKINGDIR/images$i.txt >> $WORKINGDIR/article$i.txt	#gets first image and writes img url into 3rd line of article file
 		#get date
		echo $CURRENTDATE >> $WORKINGDIR/article$i.txt		#gets date and outputs into last line of article file
	done
else
        echo "ERROR: cannot find $FILE" #file not found
fi  #end if


#Here we build the individual pages along with the index page.
for ((i=1; i<4; i++))
do
	echo $i
	ARTICLE=./src/articles/$CURRENTDATE/article$i.txt
	URL=$(sed "1q;d" $ARTICLE)
	TITLE=$(sed "2q;d" $ARTICLE)
	IMG=$(sed "3q;d" $ARTICLE)
	DATE=$(sed "4q;d" $ARTICLE)
	touch ./src/articles/$CURRENTDATE/article$i.html
	echo "
	<!DOCTYPE html>
	<html lang="en">
	<head>
    		<meta charset="UTF-8">
    		<meta http-equiv="X-UA-Compatible" content="IE=edge">
    		<meta name="viewport" content="width=device-width, initial-scale=1.0">
    		<title>$TITLE</title>
    		<link rel="stylesheet" href="../../style.css">
	</head>
	<body>
    		<h1>$TITLE</h1>
    		<img src="$IMG" alt="$TITLE">
    		<p>Scrapped on $DATE</p>
    		<p><a href="$URL">Original Article on TV2.no/nyheter</a></p>
    		<p><a href="../../index.html">Main Page</a></p>
	</body>
	</html>	
        " > ./src/articles/$CURRENTDATE/article$i.html
done

touch ./src/index.html
echo "
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>News Source - Your Best Source of Online News Since 1882</title>
	<link rel="stylesheet" href="./style.css">
</head>
<body>
	<h1>Today's Headlines</h1>
	<ul>
" > ./src/index.html

for ((i=1;i<4;i++))
do
	ARTICLE=./src/articles/$CURRENTDATE/article$i.txt
	URL=$(sed "1q;d" $ARTICLE)
	TITLE=$(sed "2q;d" $ARTICLE)
	echo "<li>" >> ./src/index.html
	echo "<a href="./articles/$CURRENTDATE/article$i.html">" >>./src/index.html
	echo $TITLE >> ./src/index.html
	echo "</a>" >>./src/index.html
	echo "</li>" >> ./src/index.html
done

echo "</ul>
</body>
</html>" >> ./src/index.html
echo "Index and pages compiled."


#call repo update
./repoUpdate.sh "Scraped $CURRENTDATE news" 


#Here we need to update NginX files
sudo cp -r src/* /var/www/html/
