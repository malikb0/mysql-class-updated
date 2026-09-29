# Class 03

```sql
--create sample data entries 
insert into person (
    firstName, 
    lastName, 
    age, 
    gender
) values 
( 'hanzla', 'aslam', 17,'M' ),
( 'abdul', 'hayee', 18,'M' ),
( 'adeel', 'javaid', 22,'M' ),
( 'abdul', 'rehman', 18,'M' )

-- deleted extra row from table 
delete from person 
where firstName = 'testPerson';

-- added duplicate entry into table 
insert into person (
    firstName, 
    lastName, 
    age, 
    gender
) values 
( 'hanzla', 'aslam', 17,'M' )


-- delete from table with first name condition along with limit of 1. 

delete from person 
where firstName = 'hanzla'
limit 1;


-- alter table add sr.No to person table with constraints primary key not null auto increment

alter table person
add column sr_no int not null  primary key auto_increment;


-- check table structure after adding pk column with describe person

-- crate dummy column to check alter query 

alter table person 
add column dummy int not null unique; --error becuase of prevous record 

delete from person; -- deleted old record for unique column entry;

alter table person 
add column dummy int not null unique;-- run again without error

--created new dummy entires with unique column dummy; 
insert into person (
    firstName, 
    lastName, 
    age, 
    gender,
    dummy
) values 
( 'hanzla', 'aslam', 17,'M', 101),
( 'abdul', 'hayee', 18,'M', 102),
( 'adeel', 'javaid', 22,'M', 103),
( 'abdul', 'rehman', 18,'M' ,104);
```
