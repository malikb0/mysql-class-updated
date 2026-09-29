# Class 01-02

```sql
/*
created a user using phpmyadmin with same name database creation and assigned it all privileges on that database. 
-- database connection from commandline, created from different ways, 
--1 from xampp shell which directly open sql shell for database connection. 
--2 from xampp/bin/ directory with mysql command. 
*/
  mysql -h localhost -u testuser1 -p ;

/* 
explore the server with several commands and also created some new database. 


*/

show databases;

create database test2;

-- database switching through use command 

use testuser1; -- switch to user own database 

create table person; -- personal table creation

/* 
shell commands beside sql 

cd, cls 

sql commandline interface can run shell comands with '\!' prefix like 
\! cls          used for clear screen.  
\! dir          list all files in current directory 
*/

show tables;   -- for showing all tables in a database 

create table person (
    firstName varchar(30), 
    lastName varchar(30), 
    age int, 
    gender varchar(1)           --mistake created we have to use char(1) for this as two possible values 'M' or 'F'
);


describe person; -- returns table structure details. 


insert into person (
    firstName, 
    lastName, 
    age, 
    gender
) values (
    'testPerson', 'testLastName', 30, 'M'
);
```
