# Modules

The 22 course modules, each a self-contained topic. Every module has the same seven files — see the
[file catalog](../docs/FILE_CATALOG.md#modules) for the pattern.

| # | Module | Level | Topic |
|---|---|---|---|
| 00 | [orientation-and-setup](00-orientation-and-setup/) | L0 | relational model; install MySQL via Docker; first query |
| 01 | [creating-tables-ddl](01-creating-tables-ddl/) | L1 | `CREATE`/`ALTER`/`DROP`; column types |
| 02 | [loading-data](02-loading-data/) | L1 | `INSERT`; `LOAD DATA`; CSV/source |
| 03 | [querying-select-filter-sort](03-querying-select-filter-sort/) | L1 | `SELECT`, `WHERE`, `ORDER BY`, `LIMIT` |
| 04 | [changing-data-nulls](04-changing-data-nulls/) | L1 | `UPDATE`/`DELETE`; NULL semantics |
| 05 | [aggregation](05-aggregation/) | L2 | `COUNT/SUM/AVG`; `GROUP BY`; `HAVING` |
| 06 | [joins](06-joins/) | L2 | inner/left/right; anti-joins; cross; self |
| 07 | [subqueries-ctes-window-functions](07-subqueries-ctes-window-functions/) | L2 | subqueries; `WITH`; window functions |
| 08 | [built-in-functions](08-built-in-functions/) | L2 | string, numeric, date/time; `CASE` |
| 09 | [data-types-precision](09-data-types-precision/) | L1–L2 | numeric/string/date/JSON/`ENUM` |
| 10 | [data-modeling-normalization](10-data-modeling-normalization/) | L3 | entities, relationships, 1NF/2NF/3NF |
| 11 | [keys-constraints-relationships](11-keys-constraints-relationships/) | L3 | PK/FK; `ON DELETE/UPDATE`; `information_schema` |
| 12 | [indexes-and-views](12-indexes-and-views/) | L3 | index types; covering/`EXPLAIN`; views |
| 13 | [transactions-and-concurrency](13-transactions-and-concurrency/) | L3 | ACID; isolation levels; locks |
| 14 | [stored-programs-and-triggers](14-stored-programs-and-triggers/) | L4 | procedures, functions, triggers, events |
| 15 | [users-privileges-security](15-users-privileges-security/) | L4 | accounts, `GRANT`/`REVOKE`, roles; injection |
| 16 | [performance-and-query-tuning](16-performance-and-query-tuning/) | L4 | `EXPLAIN`, index strategy, N+1 |
| 17 | [backup-and-recovery](17-backup-and-recovery/) | L4 | `mysqldump`; restore drill; point-in-time recovery |
| 18 | [server-administration-and-operations](18-server-administration-and-operations/) | L4 | config; logs; monitoring; maintenance |
| 19 | [replication-and-high-availability](19-replication-and-high-availability/) | L4 | primary/replica; GTID; failover basics |
| 20 | [mysql-from-applications](20-mysql-from-applications/) | L4 | Python access; pooling; parameterized queries |
| 21 | [capstone](21-capstone/) | L4 | design → seed → query → optimise → secure → back up |

## Running a module

```bash
make sql FILE=modules/03-querying-select-filter-sort/examples/01-select-and-filter.sql
```

See [GETTING_STARTED.md](../docs/GETTING_STARTED.md) for setup, and [SYLLABUS.md](../SYLLABUS.md) for the
full topic breakdown.
