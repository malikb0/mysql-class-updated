# Class 17

```sql
-- Active: 1729781097784@@127.0.0.1@3306@sakila
-- expolored the different store procedures of sakila sample database

-- temporary tables scope is User only and session only. 
select * from temp_actors;


create temporary table temp_actors as  
select * from actor
where actor_id < 50;



drop table temp_actors; -- optional

-- transaction 

        -- start transaction
        -- commit
        -- rollback

    set autocommit = off; 


    select * from language;

    
    start TRANSACTION

            insert into language (name) values 
            ('Sindhi'),
            ('Pashtu');

    --commit; 

    ROLLBACK;
```
