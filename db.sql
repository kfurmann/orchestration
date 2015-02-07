create database DATABASE_NAME;
use DATABASE_NAME;
alter database DATABASE_NAME CHARACTER SET utf8 COLLATE utf8_polish_ci;
create user DB_USER identified by 'DB_PASSWORD';
grant all on DATABASE_NAME to DB_USER;
