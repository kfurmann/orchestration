#!/bin/bash
DIR=/var/www
sudo apt-get -y install git
sudo rm -rf $DIR/* $DIR/.*
cd $DIR
sudo git clone https://github.com/amarcinkowski/hospitalpage .
./install-server.sh 
./install-dependencies.sh 
./install-wp-cli.sh 
./install-wp-all.sh 
#phpunit -c phpunit-wpdb.xml 

