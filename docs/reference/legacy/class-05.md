# Class 05

```sql
-- class 5 data exploring quries 

person table with 100 rows data 
```

| Field | Type | Null | Key | Default | Extra |
|---|---|---|---|---|---|
| firstName | varchar(30) | YES |  | NULL |  |
| lastName | varchar(30) | YES |  | NULL |  |
| age | int(11) | YES |  | NULL |  |
| gender | varchar(6) | YES |  | NULL |  |
| sr_no | int(11) | NO | PRI | NULL | auto_increment |
| un_key | int(11) | NO | UNI | NULL |  |

```sql
6 rows in set (0.025 sec)

-- distinct statement 
    
    select distinct firstName, gender 
    from person;

    select distinct gender 
    from person;

    select distinct age 
    from person;

-- where clause 

    select * from person 
    where age >= 22;

    select * from person 
    where firstName = 'Eddy';

    -- where clause with like and wildcard % search of strings 
    select * from person 
    where firstName like "A%";



-- order by clause   ASC and DESC
    select * 
    from person 
    order by firstName; 

-- and 
    select * 
    from person 
    where (firstName like "A%" and age < 25)
    order by age;

-- or 
 select * 
    from person 
    where (firstName like "A%" or  age < 25)
    order by age;
-- not
  select * 
    from person 
    where (firstName like "A%" and not( age < 25))
    order by age;

-- insert into 

    insert into person 
    values
    ('jhon', null, 20, 'Male', default ,124),
    ('jhon', 'son', null, 'Male', default ,125),
    ('jhon', 'son', 20, null, default ,126),
    (null, null, null, null, default ,127);


-- select with complex where clause 
    select * from person where un_key > 122 and un_key < 128;
```

| firstName | lastName | age | gender | sr_no | un_key |
|---|---|---|---|---|---|
| NULL | jhon | 20 | Male | 993 | 123 |
| jhon | NULL | 20 | Male | 994 | 124 |
| jhon | son | NULL | Male | 995 | 125 |
| jhon | son | 20 | NULL | 996 | 126 |
| NULL | NULL | NULL | NULL | 997 | 127 |

```sql
5 rows in set (0.001 sec)

-- null values 
    select * from person 
    where firstName is null;

-- update 
    update person
    set firstName = 'jhon'
    where firstName  is null;

-- delete 

    delete from person 
    where un_key in (123, 124, 125, 126, 127)
    limit 5;
```
