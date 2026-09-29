# Module 18 — Server Administration & Operations

> **Level:** L4 · **Prereqs:** `17-backup-and-recovery` · **Time:** ~2 h · **Original class(es):** new (gap)

## Why this module

The café chain runs on a single MySQL server. Behind every order, payment and report is one process listening on port 3306 — and that server needs more than queries to keep running smoothly. A bad buffer pool size can cause spills; a stuck session can freeze checkout; a table left unanalyzed can slow the daily sales graph for hours.

Administration is care, not just SQL. It means reading the settings in effect, watching who's connected and what the counters are telling you, turning the slow log on when things go wrong, and running maintenance so tables stay fast and intact. This module puts all of that into a short series of exercises you can do yourself.

## What you'll learn

- Read the server's configuration and storage engines with `SHOW VARIABLES` and `information_schema.engines`
- Watch live sessions and status counters, including the slow-query counter
- Turn the slow-query log on and off safely — and understand why `SET GLOBAL` does not change your current session
- Run routine maintenance (`ANALYZE`, `CHECK`, `OPTIMIZE`) and read table sizes from `information_schema`

## Prerequisites

```bash
make setup && make up && make seed
```

This creates the `shopdb` database with 12 persons, 6 customers, 2 stores, 5 employees, 4 categories, 10 products, 8 orders, 14 order items and 6 payments.

## What you'll run / build

You will connect to MySQL as the server's admin account (`root`) and read its configuration with `SELECT @@…` queries. You will turn the slow-query log on and off, watch live sessions and counters, and run maintenance commands that refresh statistics and rebuild indexes. The only file you execute is a single SQL script that restores every setting it changes and leaves 10 tables untouched.

## How to run it

```bash
python3 dbctl.py sql --file modules/18-server-administration-and-operations/examples/01-server-administration-and-operations.sql
```

The file is net-neutral: it turns the slow log on, sets `long_query_time` to 0 for this session, runs several queries, then restores everything back exactly as you found it. It also refreshes statistics and checks table integrity without altering data or row counts. The script runs as the admin account (`root`) because `SET GLOBAL` changes server-wide settings and requires the `SYSTEM_VARIABLES_ADMIN` privilege.

## This folder

| File | Purpose |
|---|---|
| `README.md` (this guide) | overview and instructions |
| `notes.md` | concepts, worked example and common errors |
| `assets/server-operations.md` | the admin reference card: knobs, logs and maintenance |
| `examples/01-server-administration-and-operations.sql` | runnable, net-neutral — do not edit |
| `exercises/README.md` | four practice tasks |
| `solutions/01-exercises.sql` | answers (try first!) |
| `checklist.md` | self-check items |

## Next

Module 19 — Replication & High Availability. The server you looked over today is one node; the next module shows you how to add a second and keep the data consistent across both.

[Back to course index](../../SYLLABUS.md)