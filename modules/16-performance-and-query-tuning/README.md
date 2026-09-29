# Module 16 — Performance & Query Tuning

> **Level:** L4 · **Prereqs:** `15-users-privileges-security` · **Time:** ~2 h · **Original class(es):** new (gap)

## Why this module

You have been running a café for months now. Customers come and leave every day. An order summary that used to open in milliseconds now takes several minutes to load. Something is wrong — but not with your hardware, or with the café itself. The problem almost always has one root: MySQL has read every row it can find instead of following an index.

When you learn how to look under the hood — reading a query plan and choosing indexes that genuinely help — the path to fixing the slow query becomes obvious and often simple. You will see the difference between a full table scan (`type = ALL`) and an index lookup (`ref`, `const`, `range`), learn why wrapping a column in a function can defeat an index, and understand how one join beats a correlated subquery that runs once per row.

## What you'll learn

- Read an `EXPLAIN` plan and tell a full scan (`type = ALL`) from an index lookup (`ref`, `const`, `range`)
- Add an index and show the plan change from a full scan to an index lookup, then read its cardinality
- Explain why a function wrapped around a column, or a low-cardinality column, can stop an index being used — and rewrite the filter as a range
- Recognise the N+1 pattern (a correlated subquery re-run per row) and replace it with a single join

## Prerequisites

```bash
make setup && make up && make seed
```

This creates the `shopdb` database with 12 persons, 6 customers, 2 stores, 5 employees, 4 categories, 10 products, 8 orders, 14 order items and 6 payments.

## What you'll run / build

- A five-thousand-row practice table to see real performance differences instead of tiny seeded data
- An index on `orders.status` that turns a full scan into an index lookup — the fix you would ship in production
- A correlated subquery rewritten as a single join, replacing N+1 inner lookups with one pass over both tables

## How to run it

```bash
python3 dbctl.py sql --file modules/16-performance-and-query-tuning/examples/01-performance-and-query-tuning.sql
```

The file is net-neutral — it does not change the `shopdb` schema or seed data. Every lesson starts from exactly the same known state.

## This folder

| File | Purpose |
|---|---|
| `README.md` (this guide) | overview and instructions |
| `notes.md` | concepts, worked example and common errors |
| `assets/query-tuning.md` | the EXPLAIN reference card and the query smells to avoid |
| `examples/01-performance-and-query-tuning.sql` | runnable, net-neutral — do not edit |
| `exercises/README.md` | four practice tasks |
| `solutions/01-exercises.sql` | answers (try first!) |
| `checklist.md` | self-check items |

## Next

**Module 17 — Backup & Recovery**. Learn how to protect your café's data with real-world backup tools, understand point-in-time recovery, and restore from a backup without losing information.

[Continue →](../../SYLLABUS.md)
