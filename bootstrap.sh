#!/bin/bash
DIR=/var/www
sudo apt-get -y install git
sudo rm -rf $DIR/* $DIR/.*
cd $DIR
sudo -u vagrant git clone https://github.com/amarcinkowski/hospitalpage .
./install-server.sh 
./install-wp-cli.sh 
sudo -u vagrant ./install-dependencies.sh f9939b8e7846a5bcfbfaea82bc3485ab5531e45d
sudo -u vagrant ./install-wp-all.sh 
sudo ./install-db.sh
#phpunit -c phpunit-wpdb.xml 
