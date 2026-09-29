# Module 03 — Querying: SELECT, Filter, Sort

> **Level:** L1 · **Prereqs:** Module 02 · **Time:** ~2 h · **Original class(es):** Class 5, 7

## Why this module

You've built your tables and loaded data into them. Now you need to ask the database questions — find products by price, identify orders in a date range, list active items sorted by category. This module teaches the core of SQL querying: selecting columns with `SELECT`, filtering rows with `WHERE` (including comparisons, pattern matching, and null checks), sorting results with `ORDER BY`, and trimming output with `LIMIT` and `DISTINCT`. All queries are read-only; nothing in your café's schema changes.

## What you'll learn

- How to select specific columns (`SELECT col1, col2`) instead of fetching everything (`SELECT *`).
- How to filter rows with `WHERE`: comparison operators (`=`, `<`, `>`), pattern matching (`LIKE`), membership lists (`IN`), ranges (`BETWEEN`), and null checks (`IS NULL`).
- How to sort results with one or more keys using `ORDER BY ASC/DESC`.
- How to trim output with `LIMIT N` and remove duplicates with `DISTINCT`.

## Prerequisites

You need **Module 02 — Loading Data** completed, plus a running `shopdb` database with the café's tables seeded. If you haven't done that yet:

```bash
make setup && make up && make seed        # once, if you haven't already
```

## What you'll run / build

You'll execute a series of read-only queries against the `shopdb` café schema — exactly 10 tables, with `products` holding 10 rows and `orders` holding 8. The module's runnable artefact is in `examples/01-select-and-filter.sql`.

## How to run it

> 🎯 Goal: by the end of this section you can select columns, filter with `WHERE`, sort with `ORDER BY`, and trim with `LIMIT` — all on a real database.

```bash
python3 dbctl.py sql --file modules/03-querying-select-filter-sort/examples/01-select-and-filter.sql
```

## This folder

| File | What it is |
| --- | --- |
| `notes.md` | Concept explanation, a worked example, and the vocabulary to remember. |
| `examples/01-select-and-filter.sql` | Runnable script: select, filter, sort, limit queries against `shopdb`. |
| `exercises/README.md` | Self-challenge tasks with goals, hints, and verification commands. |
| `solutions/01-exercises.sql` | Runnable solutions so you can compare after trying. |
| `checklist.md` | An "I can…" self-check for the skills in this module. |
| `assets/query-pipeline.md` | A diagram of how SQL clauses are evaluated (FROM → WHERE → SELECT → ORDER BY → LIMIT). |

## Next

→ Module 04 — Changing Data & NULLs (`UPDATE`, `DELETE`, three-valued logic). Back to the [syllabus](../../SYLLABUS.md).