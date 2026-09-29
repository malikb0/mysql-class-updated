# Module 20 — MySQL from Applications

> **Level:** L4 · **Prereqs:** `19-replication-and-high-availability` · **Time:** ~2 h · **Original class(es):** new (gap)

## Why this module

The café's website and till both talk to the same database, `shopdb`. An application must connect from code, pool connections efficiently, and pass user input safely so it can never become SQL. You'll see how a real Python app opens a connection, reads data with bound parameters, and writes back — all while connecting as the least-privilege `shop` account rather than `root`.

## What you'll learn

- Explain how an application connects to MySQL and why connection pooling matters
- Read a connection's identity and the server's connection limits
- Use parameterized statements (`PREPARE`/`EXECUTE` and SQLAlchemy bindings) to avoid SQL injection
- Run a real Python app that reads and writes `shopdb` as the least-privilege `shop` user

## Prerequisites

Make sure you're set up:

```bash
make setup && make up && make seed
```

This creates the `shopdb` database with 12 persons, 6 customers, 2 stores, 5 employees, 4 categories, 10 products, 8 orders, 14 order items and 6 payments. The app itself needs two Python packages — run `python3 -m pip install -r modules/20-mysql-from-applications/requirements-app.txt`.

## What you'll run / build

You'll execute SQL directly against `shopdb` to inspect connections and prepared statements. Then you'll run a real Python application that uses SQLAlchemy with PyMySQL, connects as `shop`, and safely reads products by category — demonstrating parameterized queries end-to-end.

## How to run it

```bash
python3 dbctl.py sql --file modules/20-mysql-from-applications/examples/01-mysql-from-applications.sql
```

The SQL file is net-neutral (leaves 10 tables). The example app runs with:

```bash
python3 modules/20-mysql-from-applications/app/query_shop.py
```

## This folder

| File | Purpose |
|---|---|
| `README.md` (this guide) | overview and instructions |
| `notes.md` | concepts, worked example and common errors |
| `assets/app-connectivity.md` | connections, pooling and parameterized queries at a glance |
| `examples/01-mysql-from-applications.sql` | runnable, net-neutral — do not edit |
| `app/query_shop.py` | the example Python application |
| `requirements-app.txt` | dependencies for the app (SQLAlchemy + PyMySQL) |
| `exercises/README.md` | four practice tasks |
| `solutions/01-exercises.sql` | answers (try first!) |
| `checklist.md` | self-check items |

## Next

Module 21 — Capstone. The full course list is in [`../../SYLLABUS.md`](../../SYLLABUS.md).
