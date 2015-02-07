#!/usr/bin/env bash
PATH=.:$PATH
ECLIPSE_JEE=eclipse-jee-luna-SR1a-linux-gtk-x86_64.tar.gz
ECLIPSE_PHP=eclipse-php-luna-SR1a-linux-gtk-x86_64.tar.gz
SERVER=http://mirror.netcologne.de/eclipse/technology/epp/downloads/release/luna/SR1a/
#add repos
add-apt-repository -y ppa:webupd8team/java
curl -sL https://deb.nodesource.com/setup | sudo bash -
#update
apt-get update
DEBIAN_FRONTEND=noninteractive apt-get -y upgrade
#deb packages
apt-get install -y vim
apt-get install -y curl
apt-get install -y git
echo "Europe/Warsaw" > /etc/timezone
dpkg-reconfigure -f noninteractive tzdata
# ubuntu 12.04 and previous (no add-apt-repository)
# apt-get install -y python-software-properties
# apache
function apache {
apt-get install -y apache2
a2enmod rewrite
}
#mysql

function mysql {
echo "mysql-server-5.5 mysql-server/root_password password nA8Wedeg" | sudo debconf-set-selections
echo "mysql-server-5.5 mysql-server/root_password_again password nA8Wedeg" | sudo debconf-set-selections 
apt-get install -y mysql-server-5.5
}
#samba
function samba {
apt-get install -y samba
}
#cifs
function cifs {
apt-get install -y cifs-utils
}
#php
function php {
apt-get install -y php5 php5-curl php5-xdebug 
echo 'phpmyadmin phpmyadmin/dbconfig-install boolean true' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/app-password-confirm password nA8Wedeg' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/mysql/admin-pass password nA8Wedeg' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/mysql/app-pass password nA8Wedeg' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2' | debconf-set-selections
apt-get install -y phpmyadmin
}
#java8
function java8 {
echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
apt-get install -y oracle-java8-installer
apt-get install -y oracle-java8-set-default
}
#vagrant specific
function vagrant {
if ! [ -L /var/www ]; then
  rm -rf /var/www
  ln -fs /vagrant /var/www
fi
}
#nodejs (required by phpdev & javadev)
function nodejs {
#apt-get purge nodejs npm
apt-get install -y nodejs
apt-get install -y npm
npm config set registry http://registry.npmjs.org/
}
#phpdev
function phpdevtools {
#problem
curl -sS https://getcomposer.org/installer | php
#sudo mv composer.phar /usr/bin/composer
npm install -g bower
npm install -g grunt-cli
}
#javadev
function javadevtools {
sudo apt-get install -y maven
cp /vagrant/settings.xml ~/.m2/
npm install -g nodeclipse
}
#eclipse (export PATH=.:$PATH or eclipse in PATH)
function eclipsejee {
cd /vagrant
if [ ! -f $ECLIPSE_JEE ]; then 
  wget -q "$SERVER/$ECLIPSE_JEE"; 
fi
tar -zxf "/vagrant/$ECLIPSE_JEE"
mv /vagrant/eclipse /vagrant/eclipsejee
echo "eclipse plugins"
cd /vagrant/eclipsejee
nodeclipse install testng from luna
}
# docker
function docker {
curl -sSL https://get.docker.com/ubuntu/ | sudo sh
#docker run -p 5000:5000 registry
docker run -name internal_registry -d -p 5000:5000 samalba/docker-registry
docker run -d -p 8080:8080 -p 28015:28015 -p 29015:29015 dockerfile/rethinkdb
docker run -name shipyard -p 8005:8005 -d shipyard/shipyard
}
mysql
samba
cifs
apache
php
java8
nodejs
phpdevtools
javadevtools
eclipsejee
#docker
vagrant
