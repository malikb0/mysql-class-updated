# Original Tables

```sql
-- create table customers, addresses , persons
        
    /* customer:
        customerId int not null primary key auto_increment, 
        personId int, 
        email varchar(50), 
        phone varchar(50), 
        addressId int 
       address:
        addressId int not null primary key auto_increment,
        street varchar(100),
        city varchar(50), 
        country varchar(50) 
       persons:
        personId int not null primary key auto_increment,
        firstName varchar(50),
        lastName varchar(50),
        dob Date, 
        gender varchar(20),
        age int
    employees:
        employeeId int not null primary key auto_increment,
        personId int, 
        addressId int, 
        supervisorId int
    */

        -- customers table

        create table customers (
                customerId int not null primary key auto_increment, 
                personId int, 
                email varchar(50), 
                phone varchar(50), 
                addressId int
        );
```

| Field | Type | Null | Key | Default | Extra |
|---|---|---|---|---|---|
| customerId | int(11) | NO | PRI | NULL | auto_increment |
| personId | int(11) | YES |  | NULL |  |
| email | varchar(50) | YES |  | NULL |  |
| phone | varchar(50) | YES |  | NULL |  |
| addressId | int(11) | YES |  | NULL |  |

```sql
        5 rows in set (0.032 sec)

        -- addresses table 

        create table addresses (
        addressId int not null primary key auto_increment,
                street varchar(100),
                city varchar(50), 
                country varchar(50)
        );
```

| Field | Type | Null | Key | Default | Extra |
|---|---|---|---|---|---|
| addressId | int(11) | NO | PRI | NULL | auto_increment |
| street | varchar(100) | YES |  | NULL |  |
| city | varchar(50) | YES |  | NULL |  |
| country | varchar(50) | YES |  | NULL |  |

```sql
        4 rows in set (0.024 sec)


    -- create persons table 
    create table persons(
        personId int not null primary key auto_increment,
        firstName varchar(50),
        lastName varchar(50),
        dob Date, 
        gender varchar(20),
        age int
    );
```

| Field | Type | Null | Key | Default | Extra |
|---|---|---|---|---|---|
| personId | int(11) | NO | PRI | NULL | auto_increment |
| firstName | varchar(50) | YES |  | NULL |  |
| lastName | varchar(50) | YES |  | NULL |  |
| dob | date | YES |  | NULL |  |
| gender | varchar(20) | YES |  | NULL |  |
| age | int(11) | YES |  | NULL |  |

```sql
        6 rows in set (0.025 sec)

        -- employee table 

        create table employees(
        employeeId int not null primary key auto_increment,
        personId int, 
        addressId int, 
        supervisorId int
        );
        describe employees;

  
```

| Field | Type | Null | Key | Default | Extra |
|---|---|---|---|---|---|
| employeeId | int(11) | NO | PRI | NULL | auto_increment |
| personId | int(11) | YES |  | NULL |  |
| addressId | int(11) | YES |  | NULL |  |
| supervisorId | int(11) | YES |  | NULL |  |

```sql
        4 rows in set (0.019 sec)


       
```
