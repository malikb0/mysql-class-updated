# Module 21 — Capstone

> **Level:** L4 · **Prereqs:** `20-mysql-from-applications` · **Time:** ~3 h · **Original class(es):** new (gap)

## Why this module

Every skill in the course meets here. You build a tiny system the way a real job would, then leave the database tidy.

## What you'll learn

- Design a small schema and seed it with realistic data
- Query it with joins and aggregation
- Read an `EXPLAIN` plan and add an index that improves it
- Secure it with a least-privilege read-only role, back it up, and leave the database net-neutral

## Prerequisites

```bash
make setup && make up && make seed
```

This creates the `shopdb` database with 12 persons, 6 customers, 2 stores, 5 employees, 4 categories, 10 products, 8 orders, 14 order items and 6 payments.

## What you'll build

A small café loyalty system: design two tables, seed them, query spend per member, optimise with an index, secure with a read-only role, then back it up. Every step is net-neutral — the database ends exactly as it started.

## How to run it

```bash
python3 dbctl.py sql --file modules/21-capstone/examples/01-capstone.sql
```

The file is net-neutral (it drops every practice table and role it creates and leaves 10 tables). It runs as the admin account (`root`) because it creates a role.

## This folder

| File | Purpose |
|---|---|
| `README.md` (this guide) | overview and instructions |
| `notes.md` | the full lifecycle, worked example and common errors |
| `assets/capstone-project.md` | the six stages and the definition of done |
| `examples/01-capstone.sql` | runnable, net-neutral — do not edit |
| `exercises/README.md` | four practice tasks |
| `solutions/01-exercises.sql` | answers (try first!) |
| `checklist.md` | self-check items |

## Next

The course is complete. The full course list is in [`../../SYLLABUS.md`](../../SYLLABUS.md).
