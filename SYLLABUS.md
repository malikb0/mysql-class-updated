# MySQL — Syllabus

A hands-on, example-first MySQL course. It began as a live 17-class course; this repo is the
healed, self-study edition: every concept explained, every example runnable, every exercise solved.

- **Audience:** beginners who want to work with databases, through to job-ready data/backend skills.
- **Levels:** L0 Orient → L1 Foundations → L2 Query power → L3 Design & integrity → L4 Professional.
- **Database:** one purpose-built schema, `shopdb`, seeded in one command (`make seed`).
- **Tools:** Docker + MySQL 8, the `mysql` CLI, and (optionally) MySQL Workbench.
- **Time:** ~2 h per module for the worked example; exercises extra.

> Map of the original course → this repo lives at the end (`Legacy class map`). Diagrams, vocabulary,
> and errata are per module; start at the [README](README.md) for navigation.

## Level ladder

| Level | Name | Modules | You can… |
|-------|------|---------|----------|
| **L0** | Orient | 00 | run a database server and connect to it |
| **L1** | Foundations | 01–04 | create tables, load data, query/filter/sort, change data |
| **L2** | Query power | 05–09 | aggregate, join, subquery, and use built-in functions |
| **L3** | Design & integrity | 10–13 | model/normalize a schema, enforce integrity, index, transact |
| **L4** | Professional | 14–21 | write stored programs, secure, tune, back up, replicate, administer, and ship an app + capstone |

## Modules

| # | Module | Level | You will learn | Original class |
|---|--------|-------|----------------|----------------|
| 00 | Orientation & Setup | L0 | relational model; install MySQL via Docker; connect from CLI/Workbench; databases, users, first query | Class 1–2 |
| 01 | Creating Tables (DDL) | L1 | `CREATE/ALTER/DROP/TRUNCATE`; column types; `DESCRIBE`; adding/renaming/repositioning columns | Class 1–4, 7 |
| 02 | Loading Data | L1 | `INSERT`; `LOAD DATA`/`LOAD DATA LOCAL`; CSV/`source`; idempotent seed scripts | Class 4 |
| 03 | Querying: SELECT, Filter, Sort | L1 | `SELECT`, `WHERE`, comparison/logic, `LIKE`/`IN`/`BETWEEN`, `ORDER BY`, `LIMIT`, `DISTINCT` | Class 5, 7 |
| 04 | Changing Data & NULLs | L1 | `UPDATE`/`DELETE`; NULL semantics (`IS NULL`, three-valued logic); `LIMIT` on writes | Class 3, 5 |
| 05 | Aggregation & Grouping | L2 | `COUNT/SUM/AVG/MIN/MAX`; `GROUP BY`; `HAVING`; aggregate subqueries | Class 6 |
| 06 | Joins | L2 | inner/left/right; anti-joins; cross; self; `INSERT … SELECT`; join mistakes | Class 8, 10, 11, 12 |
| 07 | Subqueries, CTEs & Window Functions | L2 | scalar/`IN`/`EXISTS`/`ANY`/`ALL`; `WITH` (+ recursive); `ROW_NUMBER/RANK`, running totals | Class 6, 13 (extended) |
| 08 | Built-in Functions | L2 | string, numeric, date/time, `NULL`/`COALESCE`, `CASE`; `GROUP_CONCAT` | Class 7, 13 (extended) |
| 09 | Data Types & Precision | L1–L2 | numeric/string/date/JSON/`ENUM`; choosing types; `DECIMAL` vs `FLOAT` | new (gap) |
| 10 | Data Modeling & Normalization | L3 | entities/relationships, ER diagrams, 1NF/2NF/3NF, when to denormalize | new (gap; uses the `.mwb`) |
| 11 | Keys, Constraints & Relationships | L3 | PK/FK/unique/check/default; `ON DELETE/UPDATE` actions; `information_schema` | Class 13, 14 |
| 12 | Indexes & Views | L3 | index types & cardinality; covering/`EXPLAIN`; creating/replacing views | Class 15 |
| 13 | Transactions & Concurrency | L3 | ACID; `START TRANSACTION`/`COMMIT`/`ROLLBACK`/`SAVEPOINT`; isolation levels; locks | Class 17 |
| 14 | Stored Programs & Triggers | L4 | procedures, functions, triggers, events; parameters & error handling | Class 17 (Sakila tour) |
| 15 | Users, Privileges & Security | L4 | accounts, `GRANT`/`REVOKE`, roles, least privilege; SQL injection & prepared statements | new (gap) |
| 16 | Performance & Query Tuning | L4 | reading `EXPLAIN`, index strategy, avoiding N+1, schema/query smells | new (gap) |
| 17 | Backup & Recovery | L4 | `mysqldump`/`mysqlpump`; physical backup; restore drill; logical vs physical; point-in-time recovery (binlogs) | Class 9 (extended) |
| 18 | Server Administration & Operations | L4 | `my.cnf` config; logs (error/slow/general); users & roles as ops; monitoring; maintenance (`ANALYZE`/`OPTIMIZE`); storage engines; upgrades | new (gap) |
| 19 | Replication & High Availability | L4 | binlog-based primary/replica; GTID; async vs semi-sync; read replicas; failover basics | new (gap) |
| 20 | MySQL from Applications | L4 | connecting from Python (`mysql-connector`/SQLAlchemy); pooled access; safe parameterized queries | new (gap) |
| 21 | Capstone | L4 | design → seed → query → optimize → secure → back up a small system, end to end | new (gap) |

## Datasets

| Dataset | Used by | Provenance |
|---------|---------|-----------|
| `shopdb` (persons/addresses/customers/employees/products/orders/…) | all modules | built from the owner's synthetic CSVs + generated seed data |
| **Sakila** | practice (joins, routines) | Oracle/MySQL sample DB — fetched, credited |
| **Employees** (`test_db`) | practice (large-data tuning) | datacharmer/test_db — fetched, credited |

## Suggested study routes

- **Fast track (L0–L2 in a weekend):** 00 → 01 → 02 → 03 → 05 → 06.
- **Interview prep:** 03 → 05 → 06 → 07 → 11 → 16.
- **Backend/ops:** 01 → 11 → 12 → 13 → 15 → 17 → 18 → 19.
- **Full course:** 00 → 21 in order, ~2 h each + exercises.

## How each module works

Every module follows the same shape: **README** (objectives, what you'll run) → **notes.md** (concept,
worked example, vocabulary, common errors) → **examples/** (runnable) → **exercises/** (+
**solutions/**) → **checklist.md** (self-check). Nothing to install beyond the repo's one-command
setup.

## Legacy class map

| Original class | Theme | Moved into |
|----------------|-------|-----------|
| 1–2 | setup, first table | 00, 01 |
| 3–4 | DDL, constraints, CSV load | 01, 02 |
| 5–6 | querying, aggregates | 03, 04, 05 |
| 7 | SQL theory, operators, aliases | 01, 03, 08 |
| 8, 10–12 | joins | 06 |
| 9 | Workbench, dump | 17 |
| 13–14 | constraints, `information_schema` | 11 |
| 15 | indexes, views | 12 |
| 16–17 | sample DBs, temp tables, transactions, routines | 13, 14, and practice datasets |

The sanitised original transcripts are preserved under [`docs/reference/legacy/`](docs/reference/legacy/).
