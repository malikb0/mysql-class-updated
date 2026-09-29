# Glossary

The vocabulary used across the course, in plain language. Terms are introduced in the module shown.

| Term | Meaning | Module |
|---|---|---|
| **ACID** | The four guarantees of a transaction: Atomicity, Consistency, Isolation, Durability. | 13 |
| **`ANALYZE TABLE`** | Refreshes the statistics the optimizer uses to plan queries. | 18 |
| **anti-join** | Rows in one table with **no** match in another — written `LEFT JOIN … WHERE key IS NULL` or `NOT EXISTS`. | 06 |
| **cardinality** | The number of distinct values in a column (or index); high cardinality makes an index selective. | 16 |
| **`CHECK TABLE`** | Verifies a table and its indexes are not corrupted. | 18 |
| **collation** | The rules for comparing and sorting text (e.g. `utf8mb4_0900_ai_ci`). | 09 |
| **connection pool** | A small set of reusable open connections an application hands out instead of connecting per request. | 20 |
| **correlated subquery** | A subquery that references the outer row and is re-evaluated for each of them. | 07 |
| **covering index** | An index that contains every column a query needs, so the table itself is never read. | 12, 16 |
| **CTE (Common Table Expression)** | A named temporary result introduced with `WITH`, used to make a query readable. | 07 |
| **DDL / DML** | Data Definition ( `CREATE`/`ALTER`/`DROP`) vs Data Manipulation (`SELECT`/`INSERT`/`UPDATE`/`DELETE`). | 01 |
| **deterministic seed** | Fixed starting data, so every learner gets identical results. | 02 |
| **`ENUM`** | A string column restricted to a fixed list of values. | 09 |
| **`EXPLAIN`** | Shows the plan MySQL will use for a query — table order, `type`, `key`, rows, `Extra`. | 16 |
| **foreign key (FK)** | A constraint that a column's values must exist in another table's key. | 11 |
| **full table scan** | Reading every row because no usable index exists (`type = ALL`). | 16 |
| **GTID** | A globally unique transaction id that replaces fragile file-and-position coordinates in replication. | 19 |
| **InnoDB** | MySQL's transactional storage engine — the default, and the only one used by `shopdb`. | 18 |
| **index** | A B-tree structure that lets MySQL find rows without scanning the whole table. | 12 |
| **isolation level** | How much one transaction can see of another's uncommitted work (`READ COMMITTED`, `REPEATABLE READ`, …). | 13 |
| **least privilege** | Granting an account only the permissions it actually needs. | 15 |
| **logical vs physical backup** | A logical backup is SQL text (`mysqldump`); a physical backup copies the data files. | 17 |
| **normalization (1NF/2NF/3NF)** | Organising tables to remove duplication and update anomalies. | 10 |
| **parameterized statement** | A query whose values are **bound** separately from the SQL text (`?` or `:name`), so input can never be read as SQL. | 20 |
| **point-in-time recovery** | Replaying the binary log to restore a database to a moment just before a mistake. | 17 |
| **primary key (PK)** | The column(s) that uniquely identify a row. | 11 |
| **`PREPARE`/`EXECUTE`** | Server-side prepared statements: parse once, run many times with new bound parameters. | 20 |
| **primary / replica** | In replication, the server that accepts writes (primary) and the copy that replays them (replica). | 19 |
| **query plan** | The strategy the optimizer chooses for a query; read it with `EXPLAIN`. | 16 |
| **role** | A named bundle of privileges (MySQL 8) you grant to users or applications. | 15 |
| **slow-query log** | A log of queries slower than `long_query_time`. | 18 |
| **SQL injection** | An attack that splices untrusted input into a query string; prevented by binding parameters. | 15, 20 |
| **stored program** | A procedure, function, trigger or event stored and run inside the server. | 14 |
| **transaction** | A group of statements that either all succeed (`COMMIT`) or all roll back (`ROLLBACK`). | 13 |
| **view** | A saved `SELECT` that behaves like a virtual table. | 12 |
| **window function** | A function computed across a set of rows related to the current row (`OVER (…)`), keeping every row. | 07 |

## See also

- [SYLLABUS.md](../SYLLABUS.md) — where each term is taught
- [DATASETS.md](DATASETS.md) — the `shopdb` schema these terms refer to
