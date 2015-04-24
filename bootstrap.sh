#!/bin/bash
DIR=/var/www
sudo apt-get -y install git
sudo rm -rf $DIR/* $DIR/.*
sudo -u vagrant git clone https://github.com/amarcinkowski/hospitalpage .
./install-server.sh 
./install-wp-cli.sh
# su instead of sudo to get HOME dir changed to vagrant user 
su - vagrant -c "$DIR/install-dependencies.sh $1"
sudo -u vagrant ./install-wp-all.sh 
sudo -u vagrant ./install-db.sh
#phpunit -c phpunit-wpdb.xml 
