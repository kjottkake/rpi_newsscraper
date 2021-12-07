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

	touch article$i.html
	echo "
	<!DOCTYPE html>
	<html lang="en">
	<head>
    		<meta charset="UTF-8">
    		<meta http-equiv="X-UA-Compatible" content="IE=edge">
    		<meta name="viewport" content="width=device-width, initial-scale=1.0">
    		<title>$TITLE</title>
    		<link rel="stylesheet" href="../style.css">
	</head>
	<body>
    		<h1>$TITLE</h1>
    		<img src="$IMG" alt="$TITLE">
    		<p>Scrapped on $DATE</p>
    		<p><a href="$URL">Original Article on TV2.no/nyheter</a></p>
    		<p><a href="../index.html">Main Page</a></p>
	</body>
	</html>	
        " > article$i.html
done


touch index.html
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
" > index.html

for ((i=0;i<4;i++))
do
	ARTICLE=./test/$((i+1)).txt
	URL=$(sed "1q;d" $ARTICLE)
	TITLE=$(sed "2q;d" $ARTICLE)
	echo "<li>" >> index.html
	echo "<a href="$URL">" >>index.html
	echo $TITLE >> index.html
	echo "</a>" >>index.html
	echo "</li>" >> index.html
done

echo "</ul>
</body>
</html>" >> index.html
