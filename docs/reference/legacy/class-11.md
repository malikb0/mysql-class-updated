# Class 11

```sql
-- cross join 

    select * from persons as pr 
    cross join customers as cr 


 
   
   
   ;
    -- insert into select
    insert into employees (employees.`personId`)
        select persons.personId from persons;

    select * from employees;

   
    insert into employees  (employees.`addressId`) 
    SELECT `addressId` from addresses 


    --persons, addresses
    insert into employees (employees.`personId`, employees.`addressId`, employees.`supervisorId`)
    select 
    pr.`personId`, ad.`addressId`, pr2.`personId` 
    from persons pr 
    left join addresses as ad 
    on (pr.`personId` = ad.`addressId` + 100)
    left join persons as pr2 
    on pr2.`personId` = pr.`personId` + 3;
```
