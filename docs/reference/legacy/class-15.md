# Class 15

```sql
-- create index

    create INDEX idx_fname
    on persons(firstName, lastName);

    SELECT * from person 
    where `firstName` = 'Umar' or `lastName` = 'simmons';

    describe persons; 

    show index from persons;

-- views
create view vw_schemas as 
select * 
from information_schema.table_constraints
where table_name in ('persons', 'customers', 'addresses', 'employees');


select * from vw_schemas;

show tables;

select * from vw_schemas
where `TABLE_NAME`= 'customers';
```
