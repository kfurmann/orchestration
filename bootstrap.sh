#!/bin/bash
DIR=/var/www
sudo apt-get -y install git
sudo rm -rf $DIR/* $DIR/.*
cd $DIR
sudo -u vagrant git clone https://github.com/amarcinkowski/hospitalpage .
./install-server.sh 
./install-wp-cli.sh 
echo "installing deps with $1"
sudo -u vagrant ./install-dependencies.sh $1
sudo -u vagrant ./install-wp-all.sh 
sudo ./install-db.sh
#phpunit -c phpunit-wpdb.xml 
