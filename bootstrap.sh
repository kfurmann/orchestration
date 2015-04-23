#!/bin/bash
sudo apt-get -y install git
cd /var/www/
sudo git clone https://github.com/amarcinkowski/hospitalpage
mv hospitalpage/* .
mv hospitalpage/.* .
./install-server.sh 
./install-dependencies.sh 
./install-wp-cli.sh 
#./install-wp-all.sh 
#phpunit -c phpunit-wpdb.xml 

