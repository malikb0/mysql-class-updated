# Class 08

```sql
/*


three tables, customers, addresses and persons created 
first two with .csv and persons is with .sql file. 


 */

--source    '.sql file path' 

source c:/xampp/data/persons.sql;

--join
  
select * 
  from persons as pr 
  join customers as cr 
  on pr.personId = cr.personId
  order by pr.personId;


-- missuse of join logic. 
select * 
  from persons as pr 
  join customers as cr 
  on pr.personId = (cr.personId + 1)
  order by pr.personId;
```
