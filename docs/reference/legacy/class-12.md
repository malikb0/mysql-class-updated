# Class 12

```sql
-- self join

        select * from employees;

        update 
        employees
        set employees.`supervisorId` = employees.`employeeId` + 4
        where `employeeId` <= (select max(`employeeId`) from employees);
       
       -- correction of wrong supervisor ids 
        update employees
        set `supervisorId` = NULL 
        where `supervisorId` > (select max(`employeeId`) from employees);
```
