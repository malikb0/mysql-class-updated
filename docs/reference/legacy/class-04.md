# Class 04

```sql
-- table structure in database
```

| Field | Type | Null | Key | Default | Extra |
|---|---|---|---|---|---|
| firstName | varchar(30) | YES |  | NULL |  |
| lastName | varchar(30) | YES |  | NULL |  |
| age | int(11) | YES |  | NULL |  |
| gender | varchar(1) | YES |  | NULL |  |
| sr_no | int(11) | NO | PRI | NULL | auto_increment |
| dummy | int(11) | NO | UNI | NULL |  |

```sql
6 rows in set (0.031 sec)

--table values in database 
```

| firstName | lastName | age | gender | sr_no | dummy |
|---|---|---|---|---|---|
| hanzla | aslam | 17 | M | 5 | 101 |
| abdul | hayee | 18 | M | 6 | 102 |
| adeel | javaid | 22 | M | 7 | 103 |
| abdul | rehman | 18 | M | 8 | 104 |
| NULL | NULL | NULL | NULL | 10 | 105 |
| NULL | NULL | NULL | NULL | 14 | 106 |

```sql
6 rows in set (0.069 sec)

--rename column dummy with un_key

alter table person change column dummy un_key int not null;
```

| Field | Type | Null | Key | Default | Extra |
|---|---|---|---|---|---|
| firstName | varchar(30) | YES |  | NULL |  |
| lastName | varchar(30) | YES |  | NULL |  |
| age | int(11) | YES |  | NULL |  |
| gender | varchar(1) | YES |  | NULL |  |
| sr_no | int(11) | NO | PRI | NULL | auto_increment |
| un_key | int(11) | NO | UNI | NULL |  |

```sql
6 rows in set (0.024 sec)

-- removes rows with null values in firstName etc 

delete from person 
where firstName is NULL ;
```

| firstName | lastName | age | gender | sr_no | un_key |
|---|---|---|---|---|---|
| hanzla | aslam | 17 | M | 5 | 101 |
| abdul | hayee | 18 | M | 6 | 102 |
| adeel | javaid | 22 | M | 7 | 103 |
| abdul | rehman | 18 | M | 8 | 104 |

```sql
4 rows in set (0.001 sec)


--loaded data of 100 random rows from csv file. ( note: filter duplicates first)
     load data infile 'c:/xampp/data/dataPerson.csv'
     into table person 
     fields terminated by ','
     ignore 1 rows;
```
