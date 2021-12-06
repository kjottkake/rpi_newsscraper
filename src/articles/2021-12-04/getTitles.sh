#!/bin/bash

#opentag='<h1 itemprop=\"headline\" class=\"articleheader__title\">'
opentag='<h1'
closetag='<\/h1>'

grep $opentag test.html | sed -e 's/<[^>]*>//g' > title1.txt
#grep $opentag test.html


imagetag='<figure>'
imageclosetag='<\/figure>'
#grep $imagetag test.html | grep src

sed -n "/$imagetag/,/$imageclosetag/p" test.html | grep -oP 'data-src=\".*?\"' | grep -Po '="\K[^"]+' > images.txt




#sed -n "/$opentag/,/$closetag/p" test.html |
