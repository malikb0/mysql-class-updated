# Class 07

```sql
--     class 7 
   /* some theory about commands 

    Data Definition Language (DDL):
    
        CREATE: Creates a new table, database, or other database objects.
        ALTER: Modifies an existing database object, such as a table.
        DROP: Deletes an entire table, database, or other objects.
        TRUNCATE: Removes all records from a table, but keeps the table structure.
                  Diff between truncate and delete is performance, truncate don't 
                  record everything in logs whereas delete keep all deleted 
                  rows record and irreversible through logs.  
    
    
    Data Manipulation Language (DML):
        
        SELECT: Retrieves data from the database.
        INSERT: Adds new data to a table.
        UPDATE: Modifies existing data within a table.
        DELETE: Removes data from a table.


    Data Control Language (DCL):
     
        GRANT: Gives users access privileges to the database.
        REVOKE: Removes user access rights or privileges.
    
    Transaction Control Language (TCL):
    
        COMMIT: Saves all changes made during the current transaction.
        ROLLBACK: Reverts changes back to the last commit point.
        SAVEPOINT: Sets a savepoint within a transaction to which you can later roll back.
    
    
    Data Query Language (DQL):
        
        SELECT: Although part of DML, it is often categorized separately as DQL 
                because it is used specifically for querying data.

   

   Statements --

        SELECT: Retrieves data from a database.
        INSERT: Adds new rows to a table.
        UPDATE: Modifies existing data in a table.
        DELETE: Removes rows from a table.


    Clauses

        WHERE: Filters records based on specified conditions.
        GROUP BY: Groups rows sharing a property so aggregate functions can be applied to each group.
        ORDER BY: Sorts the result set of a query by one or more columns.
        HAVING: Filters groups based on a condition, often used with GROUP BY.


    Operators

        AND: Combines multiple conditions in a WHERE clause; all conditions must be true.
        OR: Combines multiple conditions in a WHERE clause; at least one condition must be true.
        NOT: Negates a condition in a WHERE clause.
        LIKE: Searches for a specified pattern in a column.


    Functions

        COUNT(): Returns the number of rows that match a specified condition.
        SUM(): Adds up the values in a numeric column.
        AVG(): Calculates the average value of a numeric column.
        MIN(): Returns the smallest value in a column.
        MAX(): Returns the largest value in a column.


    Other Terms

        JOIN: Combines rows from two or more tables based on a related column.
    
    Constraints
    
        PRIMARY KEY: A unique identifier for a table's records.
        FOREIGN KEY: A field in one table that uniquely identifies a row of another table.
        INDEX: Improves the speed of data retrieval operations on a table.

        */

    -- like operator , wild cards % , _ , []
            /* 
                Wildcard Characters

                    Symbol	Description
                    %	Represents zero or more characters
                    _	Represents a single character
                    []	Represents any single character within the brackets *
                    ^	Represents any character not in the brackets *
                    -	Represents any single character within the specified range *
                    {}	Represents any escaped character **
                
                        * Not supported in PostgreSQL and MySQL databases.

                        ** Supported only in Oracle databases.
            
            */

-- in operator 

--The IN operator allows you to specify multiple values in a WHERE clause.

--The IN operator is a shorthand for multiple OR conditions.

 --Betweem operator

    select * 
    from person 
    where age between 21 and 24
    order by age desc;
```

| firstName | lastName | age | gender | sr_no | un_key |
|---|---|---|---|---|---|
| Bruce | Ross | 24 | Male | 992 | 622 |
| Melissa | Martin | 24 | Female | 96 | 85 |
| Michelle | Grant | 24 | Female | 849 | 625 |
| Adele | Foster | 24 | Female | 753 | 317 |
| Bruce | Kelly | 24 | Male | 305 | 513 |
| Sawyer | Sullivan | 23 | Male | 885 | 504 |
| Marcus | Clark | 23 | Male | 879 | 139 |
| Chloe | Casey | 23 | Female | 600 | 388 |
| Bruce | Nelson | 23 | Male | 442 | 932 |
| Rosie | Martin | 23 | Female | 394 | 506 |
| Edwin | Robinson | 23 | Male | 71 | 2 |
| Hailey | Stewart | 23 | Female | 298 | 784 |
| Emma | Ross | 23 | Female | 250 | 231 |
| Natalie | Craig | 23 | Female | 286 | 39 |
| Ashton | Payne | 22 | Male | 212 | 815 |
| Brooke | Adams | 22 | Female | 860 | 393 |
| Sabrina | Phillips | 22 | Female | 824 | 765 |
| Miranda | Phillips | 22 | Female | 821 | 321 |
| Dexter | Hawkins | 22 | Male | 621 | 471 |
| Darcy | Stevens | 21 | Female | 802 | 650 |
| Fiona | Douglas | 21 | Female | 735 | 3 |
| James | Johnson | 21 | Male | 570 | 726 |
| Lucy | Craig | 21 | Female | 874 | 749 |
| Brad | Andrews | 21 | Male | 501 | 86 |
| Agata | Elliott | 21 | Female | 880 | 871 |
| Mike | Davis | 21 | Male | 100 | 757 |
| Owen | Evans | 21 | Male | 308 | 424 |

```sql
27 rows in set (0.008 sec)     

-- Alias      columns and tables 

        select sum(grp.age_groups)  
            from (

                select count(age) as "age_groups", age , gender 
                
                    from person   
                    where age >= 20 and age <= 28      
                    group by age, gender 
                    order by age desc

            ) as grp 
            where grp.gender = "Male" ;


    select
        pr.firstName as "First Name" 
    from person as pr
    limit 10; 

-- change column position 
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
6 rows in set (0.027 sec)
-- start position 
alter table person 
change column sr_no 
sr_no int not null auto_increment First;
```

| Field | Type | Null | Key | Default | Extra |
|---|---|---|---|---|---|
| sr_no | int(11) | NO | PRI | NULL | auto_increment |
| firstName | varchar(30) | YES |  | NULL |  |
| lastName | varchar(30) | YES |  | NULL |  |
| age | int(11) | YES |  | NULL |  |
| gender | varchar(6) | YES |  | NULL |  |
| un_key | int(11) | NO | UNI | NULL |  |

```sql
6 rows in set (0.028 sec)


-- after some column 

alter table person 
change column un_key 
un_key int not null after sr_no;
```

| Field | Type | Null | Key | Default | Extra |
|---|---|---|---|---|---|
| sr_no | int(11) | NO | PRI | NULL | auto_increment |
| un_key | int(11) | NO | UNI | NULL |  |
| firstName | varchar(30) | YES |  | NULL |  |
| lastName | varchar(30) | YES |  | NULL |  |
| age | int(11) | YES |  | NULL |  |
| gender | varchar(6) | YES |  | NULL |  |

```sql
6 rows in set (0.019 sec)

-- check constraints of a table

select * 
from information_schema.table_constraints
where table_name = 'person';
```

| CONSTRAINT_CATALOG | CONSTRAINT_SCHEMA | CONSTRAINT_NAME | TABLE_SCHEMA | TABLE_NAME | CONSTRAINT_TYPE |
|---|---|---|---|---|---|
| def | testuser1 | PRIMARY | testuser1 | person | PRIMARY KEY |
| def | testuser1 | dummy | testuser1 | person | UNIQUE |

```sql
2 rows in set (0.002 sec)

-- drop constraint and drop column 

 alter table person 
 drop constraint dummy; 
```

| Field | Type | Null | Key | Default | Extra |
|---|---|---|---|---|---|
| sr_no | int(11) | NO | PRI | NULL | auto_increment |
| un_key | int(11) | NO |  | NULL |  |
| firstName | varchar(30) | YES |  | NULL |  |
| lastName | varchar(30) | YES |  | NULL |  |
| age | int(11) | YES |  | NULL |  |
| gender | varchar(6) | YES |  | NULL |  |

```sql
6 rows in set (0.028 sec)

alter table person 
drop column un_key;
```

| Field | Type | Null | Key | Default | Extra |
|---|---|---|---|---|---|
| sr_no | int(11) | NO | PRI | NULL | auto_increment |
| firstName | varchar(30) | YES |  | NULL |  |
| lastName | varchar(30) | YES |  | NULL |  |
| age | int(11) | YES |  | NULL |  |
| gender | varchar(6) | YES |  | NULL |  |

```sql
5 rows in set (0.028 sec)
```
