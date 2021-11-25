#!/bin/bash

#curl tv2 news
curl  https://www.tv2.no/nyheter  > tv2nyheter.html


#opentag='<div class=\"article__content\">'
opentag='<article class=\"article column large-6 small-6 article--nyheter\">'
#closetag='<\/div>'
closetag='<\/article>'
#opentag='<article class=*>'
#closetag='</article>'
sed -n "/$opentag/,/$closetag/p" tv2nyheter.html > tv2articles.html

#get urls and make into new list
cat tv2articles.html | grep 'href' > tv2articleUrls.html

#gets urls from article urls
grep -oP '/nyheter/\K.*' tv2articleUrls.html | sed 's/\/\">//g' > urls_tv2.txt  


#gets image urls
#cat tv2articles.html | grep 'src' > tv2articleImageUrl.html

#remove article opening tag
#sed 's/<article class.*>//g' tv2articles.html

