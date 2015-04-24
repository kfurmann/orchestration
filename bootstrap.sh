#!/bin/bash
export APP_DIR=/var/www
sudo rm -rf $APP_DIR/* $APP_DIR/.*
sudo apt-get -y install git
sudo -u vagrant git clone https://github.com/amarcinkowski/hospitalpage $APP_DIR
sudo $APP_DIR/install-server.sh 
sudo $APP_DIR/install-wp-cli.sh
# su instead of sudo to get HOME dir changed to vagrant user 
su - vagrant -c "$APP_DIR/install-dependencies.sh $1"
sudo -u vagrant $APP_DIR/install-wp-all.sh 
sudo -u vagrant $APP_DIR/install-db.sh
#phpunit -c phpunit-wpdb.xml 
