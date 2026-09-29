# Module 02 — Loading Data

> **Level:** L1 · **Prereqs:** Module 01 · **Time:** ~2 h · **Original class(es):** Class 4

## Why this module

You've built your tables. Now you need to put data in them. A row is a record — one product, one order, one customer's visit at the café. This module teaches the three ways rows enter a table: `INSERT` for individual or batched rows, running a `.sql` file with `source`, and importing CSVs with `LOAD DATA`. You'll also learn how to reset your database idempotently so every script is safe to run again without error.

## What you'll learn

- How to use `INSERT` for single-row inserts, multi-row inserts, and inserts that omit columns (leveraging defaults).
- How to execute a `.sql` file with the MySQL CLI's `source` command or the repo's `dbctl.py sql --file`.
- How to import CSV files with `LOAD DATA LOCAL INFILE`, including enabling it on both server and client sides.
- The idempotent seed pattern: truncating tables then re-inserting data so scripts are safe to rerun.

## What you'll run / build

You'll create a table called `practice_products_load` (net-neutral for the café's 10-table schema), insert four rows using three different techniques, verify the output, and drop the table. The module's runnable artefact is in `examples/01-insert-and-load.sql`.

## How to run it

> 🎯 Goal: create a table from scratch, insert data with `INSERT` and a `.sql` file, then drop your changes so you end where you started.

```bash
make setup && make up && make seed        # once, if you haven't already
python3 dbctl.py sql --file modules/02-loading-data/examples/01-insert-and-load.sql
```

## This folder

| File | What it is |
| --- | --- |
| `notes.md` | Concept explanation, a worked example, and the vocabulary to remember. |
| `examples/01-insert-and-load.sql` | Runnable script: create table, insert rows, verify, drop. |
| `exercises/README.md` | Self-challenge tasks with goals, hints, and verification commands. |
| `solutions/01-exercises.sql` | Runnable solutions so you can compare after trying. |
| `checklist.md` | An "I can…" self-check for the skills in this module. |
| `assets/load-pipeline.md` | A diagram of how data flows into a MySQL table. |

## Next

→ Module 03 — Querying: SELECT, Filter, Sort. Back to the [syllabus](../../SYLLABUS.md).