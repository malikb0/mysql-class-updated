# Class 10

```sql
-- Active: 1727797450661@@127.0.0.1@3306@testuser1

select * from persons;

select * from addresses;
select * from customers;

-- Inner Join

    select * 
    from persons as pr 
    join customers as cr 
    on pr.personId = cr.personId
    order by pr.personId;


-- Left Join
    
    select * from customers as cr
    left join persons as pr 
    on cr.`personId` = pr.`personId`
    where pr.`personId` is null; 

-- Right Join 

     select * from customers as cr
    RIGHT join persons as pr 
    on cr.`personId` = pr.`personId`
    where cr.`personId` is null;
```
