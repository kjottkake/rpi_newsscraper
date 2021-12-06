#!/bin/bash

#opentag='<h1 itemprop=\"headline\" class=\"articleheader__title\">'
opentag='<h1'
closetag='<\/h1>'

grep $opentag test.html | sed -e 's/<[^>]*>//g' > title1.txt
#grep $opentag test.html

#sed -n "/$opentag/,/$closetag/p" test.html |
