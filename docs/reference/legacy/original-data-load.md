# Original Data Load

```sql
     -- person data load 100 rows first. 

    load data infile 'c:/xampp/data/dataPerson.csv'
     into table person 
     fields terminated by ','
     ignore 1 rows;
     
     
     -- customers data load 100 rows 
     
     load data infile '../../data/dataCustomers.csv'
     into table customers 
        fields terminated by ','
        ENCLOSED BY '"'
        LINES TERMINATED BY '\n'
    
     ignore 1 rows;
-- addresses data load 100 rows 
      load data infile '../../data/dataAddress.csv'
     into table addresses 
        fields terminated by ','
        ENCLOSED BY '"'
        LINES TERMINATED BY '\n'
    
     ignore 1 rows;

-- persons table data from sql file. 

source c:/xampp/data/persons.sql
```
