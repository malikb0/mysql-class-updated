# Module 12 — Indexes & Views

> **Level:** L3 · **Prereqs:** Module 11 — Keys, Constraints & Relationships · **Time:** ~2 h · **Original class(es):** Class 15

## Why this module

In a café that sells products to customers across stores, every customer's order is a row. As the number of orders grows past thousands (and later millions), queries that filter by `status`, join on `customer_id`, or look up a product by its `sku` start to crawl — the database reads every row it has instead of finding the right ones fast.

This module teaches you how to **find** those slow spots, add the right indexes so MySQL can skip reading irrelevant rows, and save expensive queries as views that any employee can reuse without typing them from scratch. You'll learn when an index helps and when a view saves your team — because both are powerful but misuse either hurts performance more than it helps.

## What you'll learn

- Read the indexes a table already has from `information_schema.statistics` (name, columns, uniqueness, cardinality)
- Read a query plan with `EXPLAIN` and tell a full scan (`type = ALL`) from an index lookup (`ref`, `const`)
- Create and drop an index, and explain when a covering index answers a query from the index alone
- Create, replace, query and drop a view

## Prerequisites

You need Module 11 (keys, constraints & relationships) loaded. Set up the database with:

```sh
make setup && make up && make seed
```

Then enter the MySQL shell for `shopdb`:

```sh
mysql -u root --password=password shopdb
```

## What you'll run / build

You'll inspect the indexes the `shopdb` tables already have, read `EXPLAIN` plans before and after adding an index, exploit a covering index, and create/replace/query/drop a view. Every step is net-neutral — it tidies up after itself, leaving exactly 10 tables in the database.

## How to run it

```sh
python3 dbctl.py sql --file modules/12-indexes-and-views/examples/01-indexes-and-views.sql
```

This runs all 13 steps from `notes.md` and leaves `shopdb` exactly as seeded — no extra tables, no leftover views.

## This folder

| File | Purpose |
|---|---|
| README.md | You are here — module overview |
| notes.md | Concepts, worked example, common errors & fixes |
| assets/indexes-and-views.md | Quick-reference diagram and concept summaries |
| examples/01-indexes-and-views.sql | The 13-step runnable script (net-neutral) |
| exercises/README.md | Practice tasks to deepen your understanding |
| solutions/01-exercises.sql | Solution scripts — try the exercise before peeking |
| checklist.md | Learning checklist for this module |

## Next

[Module 13 — Transactions & Concurrency](../../SYLLABUS.md) builds on everything you've learned here by teaching you how to keep orders, payments, and items consistent when multiple employees act at a shop simultaneously.
