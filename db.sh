#!/bin/bash
DIR=/vagrant/
SQL=$(cat db.sql | sed -e "s/DB_NAME/$DB_NAME/" -e "s/DB_USER/$DB_USER/" -e "s/DB_PASSWORD/$DB_PASSWORD/")
echo "installing db"
echo $SQL
echo $SQL | mysql -uroot -p$DB_PASSWORD
