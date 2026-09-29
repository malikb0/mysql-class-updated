# Module 08 — Built-in Functions

> **Level:** L2 · **Prereqs:** `07-subqueries-ctes-window-functions` · **Time:** ~2 h · **Original class(es):** Class 7, 13 (extended)

## Why this module

So far you've written queries that join tables, filter rows, and aggregate numbers. That's powerful, but real-world data is rarely clean enough to feed straight into a report or an app. Names have trailing spaces, SKUs need to be parsed, prices must be rounded to two decimal places, and dates often arrive as strings instead of proper date types. Built-in functions are MySQL's way of cleaning, reshaping, and interpreting that messy data — all inside the database so your application code stays lean.

Think of a function as a tiny calculator: it takes one or more inputs (called *arguments*) and returns a single value. Some functions are *deterministic* — given the same input they always return the same output (like `UPPER('hello')`). Others are *non-deterministic*, meaning their result can change from run to run even with identical data (for example, `RAND()`). Understanding this distinction helps you reason about caching and when it's safe to call a function in an indexable expression.

> 🎯 Goal: learn the built-in functions MySQL ships — text shaping, number rounding, date slicing, conditional logic, and null-safe aggregation.

## What you'll learn

- Build and clean text with `CONCAT`, `UPPER` / `LOWER`, `TRIM`, `REPLACE`, `LEFT`, `SUBSTRING_INDEX`.
- Compute with `ROUND`, `FLOOR`, `CEIL`, `MOD`, `ABS`, `POWER`.
- Slice dates with `DATE`, `MONTHNAME`, `DAYNAME`, `YEAR`, `DATE_ADD` / `DATE_SUB`, `LAST_DAY`, `TIMESTAMPDIFF`.
- Fill gaps with `COALESCE` and branch with `CASE`; collapse many rows into one with `GROUP_CONCAT`.

## Prerequisites

Set up the local development environment:

```bash
make setup && make up && make seed
```

This creates the `shopdb` database in MySQL with the seed data used throughout this course. See [Module 00 — Orientation & Setup](../00-orientation-and-setup/README.md) for details on `make` targets and connection strings.

## What you'll run / build

- Format names into full strings, extract email domains from addresses.
- Parse SKU codes by splitting on dashes with string slicing functions.
- Round prices to two decimal places; label each product as *budget*, *mid*, or *premium* using `CASE`.
- Extract date parts (month name, weekday, year) and compute ages at a fixed reference date.
- Replace missing supervisor names with a default value via `COALESCE`.
- Produce per-category comma-separated product lists with `GROUP_CONCAT`.

## How to run it

```bash
python3 dbctl.py sql --file modules/08-built-in-functions/examples/01-built-in-functions.sql
```

Or via the Makefile:

```bash
make sql FILE=modules/08-built-in-functions/examples/01-built-in-functions.sql
```

The example file runs clean on the seed data and produces all twelve worked examples shown in [notes.md](notes.md). **Read-only** — do not edit it.

## This folder

| File | Purpose |
|---|---|
| `README.md` (this guide) | What you'll learn, how to run, and next steps |
| `notes.md` | Concepts, worked example with real output tables, common errors |
| `assets/function-cheatsheet.md` | One-page map of the function families |
| `examples/01-built-in-functions.sql` | Runnable examples (read-only) |
| `exercises/README.md` | Four practice tasks — try first before peeking at solutions |
| `solutions/01-exercises.sql` | Answers to each exercise (read-only) |
| `checklist.md` | Self-check items to confirm mastery |

## Next

[Module 09 — Data Types & Precision](../09-data-types-precision/README.md) · [Course Index](../../SYLLABUS.md)

> 🧪 Try it: pick any exercise in `exercises/`, write the query from scratch, run it against the seed database, and check that you get the expected row count. If you don't match, ask for a hint — but resist the temptation to copy-paste an answer without understanding what it does.
