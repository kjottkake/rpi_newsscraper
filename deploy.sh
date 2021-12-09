#!/bin/bash

#install nginx
sudo apt-get update
sudo apt-get install nginx

#install git
sudo apt-get install git-all

#make folders
sudo mkdir scraper
#cd to folder
cd scraper

#clone repo
git clone https://github.com/kjottkake/rpi_newsscraper.git

#cd into repo
cd rpi_newsscraper

#run script
./scrape

#run clean up
./cleanup

#copy src folder into nginx folder
sudo cp -r src/* /var/www/html/

#Deployment Complete!
echo "Scraping Complete! Site Online!"
