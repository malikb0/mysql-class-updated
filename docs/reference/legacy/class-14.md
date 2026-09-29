# Class 14

```sql
-- foreign key with checks. 

select * 
from information_schema.table_constraints
where table_name = 'customers';

alter table customers
drop CONSTRAINT fk_personId;

SET FOREIGN_KEY_CHECKS=0;

alter table customers
add CONSTRAINT fk_personId 
FOREIGN KEY (personId) 
REFERENCES persons(personId)
on DELETE RESTRICT
on UPDATE RESTRICT; 

SET FOREIGN_KEY_CHECKS=1;

insert into customers (personId)
values (202);

update customers
set personId = 204
where customerId = 201

select * from customers 
order by customerId desc; 

insert into persons (`firstName`) values ('abc'); 



alter table customers
add CONSTRAINT fk_personId 
FOREIGN KEY (personId) 
REFERENCES persons(personId)
on DELETE CASCADE
on UPDATE CASCADE; 


update  persons
set `personId` = 203
where `personId` = 204;  


delete from persons 
where `personId` = 203
limit 1; 

select * from customers
order by `customerId` desc ;
```
