# News Scrapper! Where we scrape the shit out of news!

## What it do:

This is an automated news scraping script that scrapes contents of tv2.no/nyheter (tv2 news). This script saves daily news headlines and complies them into a new consolidated news website which is then hosted via nginx. This script is configured to run on Raspberry PI. A Raspberry PI 3+ was used in development.


## How it does it.
First our script scrapes the entire front page of tv2.no/nyheter, it then extracts the individual urls of headlines. 

Once the individual urls is extracted and cleaned up it is then complied into a list of urls.

The list of urls are then individually called upon, and the script further interrogates each individual url by downloading the contents of each url (unique news article).

Prior to the processing of each unique news article, a sub folder containing news from that day is created.

Each news article is indivdiually processed and 3 key elements are then extracted.

The key elements extracted from the article urls are as follows:
     <li>Url of the article/li>
    <li>Title of the article</li>
     <li>Image of the article</li>

Additionally a timestamp with the date of the posting/scraping of the article is also generated.

## How to run it.
After you've configured your raspberry pi you can download the project by using
```
git clone https://github.com/kjottkake/rpi_newsscraper.git
```
You can navigate into the project via
```
cd rpi_newsscraper
```

You can run the project using
```
./scrape.sh
```



## Resources and References I Used
How to write if statements in bash
https://ryanstutorials.net/bash-scripting-tutorial/bash-if-statements.php

How to check if a directory exists in bash
https://linuxize.com/post/bash-check-if-file-exists/

How to use a for loop in bash
https://www.cyberciti.biz/faq/bash-for-loop/

How to count lines of a file
https://www.baeldung.com/linux/bash-count-lines-in-file

How to use variables
https://tldp.org/HOWTO/Bash-Prog-Intro-HOWTO-5.html

How to use bash functions
https://linuxize.com/post/bash-functions/

How to set a command as a variable
https://www.cyberciti.biz/faq/unix-linux-bsd-appleosx-bash-assign-variable-command-output/

How to get time and date
https://tecadmin.net/get-current-date-and-time-in-bash/

How to use for loops (again)
https://linuxize.com/post/bash-for-loop/

How to use for loops (ended up using the c-style loop)
https://stackoverflow.com/questions/17181787/how-to-use-variables-in-a-bash-for-loop

How to concatenate in bash
https://linuxize.com/post/bash-concatenate-strings/

How to get nth line from file
https://stackoverflow.com/questions/6022384/bash-tool-to-get-nth-line-from-a-file/6022431

How to grep src from html
https://stackoverflow.com/questions/44055023/using-grep-to-get-src-attribute-from-html-file

