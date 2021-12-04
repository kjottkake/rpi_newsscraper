#!/bin/bash

#get tv2 news and write into tv2nyheter file
curl  https://www.tv2.no/nyheter  > tv2nyheter.html

#get articles elements from tv2nyheter file and write into tv2articles
opentag='<article class=\"article column large-6 small-6 article--nyheter\">'
closetag='<\/article>'
sed -n "/$opentag/,/$closetag/p" tv2nyheter.html > tv2articles.html

#get urls and make into new list
cat tv2articles.html | grep 'href' > tv2articleUrls.html

#gets urls from article urls
grep -oP '/nyheter/\K.*' tv2articleUrls.html | sed 's/\/\">//g' > urls_tv2.txt  


#gets image urls
#cat tv2articles.html | grep 'src' > tv2articleImageUrl.html

#remove article opening tag
#sed 's/<article class.*>//g' tv2articles.html

