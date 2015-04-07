#!/bin/bash
echo "mysql-server mysql-server/root_password password $DB_PASSWORD" | sudo debconf-set-selections
echo "mysql-server mysql-server/root_password_again password $DB_PASSWORD" | sudo debconf-set-selections 
sudo apt-get install -y apache2 php5 libapache2-mod-php5 mysql-server php5-mysql php5-curl phpunit subversion nodejs
sudo service apache2 restart
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer
cd /var/www/
sudo git clone https://github.com/amarcinkowski/hospitalpage
mv hospitalpage/* .
mv hospitalpage/.* .
composer up -vvv
cp resources/.env .
./install-dependencies.sh 
./install-wp-cli.sh 
./install-wp-tests.sh wordpress root '' 127.0.0.1 latest
wp core install --url=127.0.0.1 --title=x --admin_user=root --admin_email=x@x.w --admin_password=x
wp blog create --url=127.0.0.1
wp core multisite-convert
phpunit -c phpunit-wpdb.xml 
