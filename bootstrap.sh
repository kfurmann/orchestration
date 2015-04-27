#!/bin/bash
# su instead of sudo to get HOME dir changed to vagrant user 

#vagrant prepare
export APP_DIR=/var/www
export REPO_DIR=/home/vagrant/repo
sudo rm -rf $APP_DIR $REPO_DIR/*
sudo apt-get update
sudo apt-get -y install git
github_projects=(hospitalpage punction epidemio)
for i in "${github_projects[@]}"
do
	echo "PROJECT $i"
	sudo -u vagrant git clone https://github.com/amarcinkowski/$i $REPO_DIR/$i
done
sudo rm -rf $APP_DIR
sudo ln -s $REPO_DIR/hospitalpage $APP_DIR

#server prepare
sudo $APP_DIR/install-server.sh

#wp prepare
sudo $APP_DIR/install-wp-cli.sh
su - vagrant -c "/var/www/install-dependencies.sh $1"
su - vagrant -c "$APP_DIR/install-wp-all.sh"
su - vagrant -c "$APP_DIR/install-db.sh"

#run tests
#phpunit -c phpunit-wpdb.xml 
