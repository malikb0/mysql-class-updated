# Module 09 — Data Types & Precision

> **Level:** L1–L2 · **Prereqs:** `08-built-in-functions` · **Time:** ~2 h · **Original class(es):** new (gap)

## Why this module

Data types are the backbone of every query. A number stored as `DECIMAL(10,2)` behaves differently from one stored as `FLOAT`, and a value too long for its column is rejected in strict mode — for both `CHAR` and `VARCHAR`. Choosing the right type saves storage, prevents silent bugs, and makes your schema self-documenting.

This module teaches you to inspect declared types, compare exact versus approximate numerics, choose safe types for money, IDs, short codes and free text, distinguish characters from bytes, and wield `ENUM`, dates and JSON as first-class column types.

## What you'll learn

- Read a column's declared type from `information_schema` (`COLUMN_TYPE`, precision, scale)
- Choose the right type for money, IDs, short codes, free text, dates, fixed sets and documents
- Explain why `DECIMAL` is exact and `FLOAT`/`DOUBLE` is approximate
- Tell characters from bytes (`CHAR_LENGTH` vs `LENGTH`) and `CHAR` from `VARCHAR`
- Recognise range, truncation and `UNSIGNED` surprises before they bite

## Prerequisites

Set up the local environment:

```bash
make setup && make up && make seed
```

This creates the `shopdb` database with 12 persons, 6 customers, 2 stores, 5 employees, 4 categories, 10 products, 8 orders, 14 order items and 6 payments.

## What you'll run / build

- Inspect declared column types via `information_schema.COLUMNS`
- Compare `DECIMAL(10,2)` with `DOUBLE` to see exact versus approximate arithmetic
- See how `CHAR`/`VARCHAR`, `ENUM`, dates and JSON behave under real data

## How to run it

```bash
python3 dbctl.py sql --file modules/09-data-types-precision/examples/01-data-types-precision.sql
```

This runs the single example file in this module. Every SQL block you see is already written — **read-only**. Do not edit `examples/01-data-types-precision.sql`.

## This folder

| File | Purpose |
|---|---|
| `README.md` (this guide) | overview and instructions |
| `notes.md` | concepts, worked example and common errors |
| `assets/type-selection.md` | a decision chart for picking the right type |
| `examples/01-data-types-precision.sql` | runnable, read-only — do not edit |
| `exercises/README.md` | four practice tasks |
| `solutions/01-exercises.sql` | answers (try first!) |
| `checklist.md` | self-check items |

## Next

The next module is **Module 10 — Data Modeling & Normalization**; see the [Course Index](../../SYLLABUS.md) for the full list and what comes after.
