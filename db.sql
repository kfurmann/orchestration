create database DB_NAME;
use DB_NAME;
alter database DB_NAME CHARACTER SET utf8 COLLATE utf8_polish_ci;
create user DB_USER identified by 'DB_PASSWORD';
grant all on DB_NAME to DB_USER;
