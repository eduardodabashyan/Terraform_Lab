#!/bin/bash
echo "Installing git"
sudo apt install git -y
echo "Checking git version"
git --version
git clone https://github.com/Anirban2404/phpMySQLapp.git

echo "Installing Apache" 
sudo apt update
sudo apt install apache2 -y
sudo ufw app list
sudo ufw allow 'Apache'
sudo ufw status
sudo systemctl start apache2
sudo systemctl enable apache2
sudo systemctl status apache2

echo "Copy project files to Apache directory"
cp -r phpMySQLapp/* /var/www/html/


echo "remove apache startpage"
sudo rm -rf /var/www/html/index.html

sudo sed -i -e 's/127.0.0.1/${book_dbhostname}/g' /var/www/html/books/includes/bookDatabase.php 
sudo sed -i -e 's/127.0.0.1/${movie_dbhostname}/g' /var/www/html/movies/includes/movieDatabase.php

