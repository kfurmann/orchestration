#!/bin/bash
DIR=/vagrant/
SQL=$(cat db.sql | sed -e "s/DATABASE_NAME/$DATABASE_NAME/" -e "s/DB_USER/$DB_USER/" -e "s/DB_PASSWORD/$DB_PASSWORD/")
echo $SQL
echo $SQL | mysql -uroot -p$DB_PASSWORD
