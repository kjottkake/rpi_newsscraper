#!/bin/bash

#curl tv2 news
curl  https://www.tv2.no/nyheter  > tv2nyheter.html


opentag='<div class=\"article__content\">'
closetag='<\/div>'
#opentag='<article class=*>'
#closetag='</article>'
sed -n "/$opentag/,/$closetag/p" tv2nyheter.html > articles.html


