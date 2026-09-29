# Class 13

```sql
-- union

    select firstName from persons
    where gender = 'Male'
    UNION all   
    select lastName from persons
    where gender = 'Female' ;


-- having 
 -- already done with group by 
-- exists
    select email from 
    customers
    where EXISTS ( 
        select * from persons 
        where 
        persons.personId = customers.personId 
        and age > 42 );

-- any, all 
-- case

select 
firstName, 
lastName,
case
  when age >= 30 then '  30 or 30+' 
  when age < 30 then 'under 30'
end 
as Age_group ,
case
  when age >= 40 then '  40 or 40+' 
  when age < 40 then 'under 40'
end 
as Age_group 
from persons;

select * from persons 
where age < 30; 

-- foreign key constraint

alter table customers
add CONSTRAINT fk_personId 
Foreign Key (personId) REFERENCES persons(personId);

SET FOREIGN_KEY_CHECKS=1;
select * 
from information_schema.table_constraints
where table_name = 'customers';

describe customers;

-- check constraint

alter table persons 
add CONSTRAINT chk_age check ( age >= 18);



select * 
from information_schema.table_constraints
where table_name = 'persons';

describe persons;

insert into persons (age) values (18);
delete from persons where age = 18
limit 1;

alter table persons 
drop CONSTRAINT chk_age;
```
