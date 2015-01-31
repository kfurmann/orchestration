#!/usr/bin/env bash
apt-get update
DEBIAN_FRONTEND=noninteractive apt-get -y upgrade
#deb packages
apt-get install -y vim
apt-get install -y curl
apt-get install -y git
echo "Europe/Warsaw" > /etc/timezone
dpkg-reconfigure -f noninteractive tzdata
# ubuntu 12.04 and previous (no add-apt-repository)
apt-get install -y python-software-properties
# apache
function apache {
apt-get install -y apache2
a2enmod rewrite
}
#mysql
function mysql {
echo "mysql-server-5.5 mysql-server/root_password password qwe123" | sudo debconf-set-selections
echo "mysql-server-5.5 mysql-server/root_password_again password qwe123" | sudo debconf-set-selections 
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
echo 'phpmyadmin phpmyadmin/app-password-confirm password zxc123' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/mysql/admin-pass password qwe123' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/mysql/app-pass password zxc123' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2' | debconf-set-selections
apt-get install -y phpmyadmin
}
#java8
function java8 {
add-apt-repository -y ppa:webupd8team/java
apt-get update
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
apt-get purge nodejs npm
curl -sL https://deb.nodesource.com/setup | sudo bash -
apt-get install -y nodejs
apt-get install -y npm
ln -s /usr/bin/nodejs /usr/bin/node
npm config set registry http://registry.npmjs.org/
}
#phpdev
function phpdevtools {
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
npm install -g bower
npm install -g grunt-cli
}
#javadev
function javadevtools {
sudo apt-get install maven
npm install -g nodeclipse
}
#eclipse (export PATH=.:$PATH or eclipse in PATH)
function eclipsejee {
echo "eclipse plugins"
# nodeclipse install testng from luna
}
# docker
function docker {
curl -sSL https://get.docker.com/ubuntu/ | sudo sh
#docker run -p 5000:5000 registry
docker run -name internal_registry -d -p 5000:5000 samalba/docker-registry
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
#docker
vagrant
