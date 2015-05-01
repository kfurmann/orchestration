#!/usr/bin/env bash
PATH=.:$PATH

DEBIAN_FRONTEND=noninteractive apt-get -y upgrade
sudo echo "Europe/Warsaw" > /etc/timezone
sudo dpkg-reconfigure -f noninteractive tzdata

function java8 {
  sudo add-apt-repository -y ppa:webupd8team/java
  sudo apt-get update
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
  sudo apt-get install -y oracle-java8-installer
  sudo apt-get install -y oracle-java8-set-default
}

function tomcat8 {
  wget http://mirrors.ibiblio.org/apache/tomcat/tomcat-8/v8.0.21/bin/apache-tomcat-8.0.21.tar.gz
  tar xvzf apache-tomcat-8.0.21.tar.gz
  sudo mv apache-tomcat-8.0.21 /opt/tomcat
}

#add repos
sudo apt-get install -y vim curl git
java8
tomcat8


#curl -sL https://deb.nodesource.com/setup | sudo bash -

#samba
function samba {
apt-get install -y samba
}
#cifs
function cifs {
apt-get install -y cifs-utils
}
#java8
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
#javadev
function javadevtools {
sudo apt-get install -y maven
ln -s /vagrant/settings.xml /home/vagrant/.m2/settings.xml
}
#glassfish
function glassfish {
echo "glassfish download...."
cd /opt
wget -q http://dlc.sun.com.edgesuite.net/glassfish/4.1/release/glassfish-4.1.zip
echo "glassfish unzip..."
unzip -q glassfish-4.1.zip
cd /opt/glassfish4/bin
echo "glassfish start"
echo "AS_ADMIN_PASSWORD=glassfish" > pwdfile
./asadmin delete-domain domain1
./asadmin delete-jdbc-connection-pool --cascade=true DerbyPool
./asadmin create-domain hospital
echo "admin;{SSHA256}80e0NeB6XBWXsIPa7pT54D9JZ5DR5hGQV1kN1OAsgJePNXY6Pl0EIw==;asadmin" > /opt/glassfish4/glassfish/domains/hospital/config/admin-keyfile
./asadmin start-domain
./asadmin --user admin --passwordfile pwdfile enable-secure-admin
./asadmin restart-domain
#./asadmin start-database 
echo "glassfish started"
}
#mysql
#samba
#cifs
#apache
#php
#java8
#nodejs
#phpdevtools
#javadevtools
#eclipsejee
#docker
#vagrant
#glassfish
