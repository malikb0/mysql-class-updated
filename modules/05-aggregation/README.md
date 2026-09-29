# Module 05 — Aggregation & Grouping

> **Level:** L2 · **Prereqs:** Module 04 · **Time:** ~2 h · **Original class(es):** Class 6

## Why this module

You've learned how to filter rows (`WHERE`) and sort them (`ORDER BY`). But sometimes you don't want individual rows — you want *answers* about the whole table: "how many products does this café have?", "what's the average price of tea items?", "which categories are overstock?". Aggregation turns many rows into a few answers. Every query in this module is **read-only** — `SELECT` only, never touching data.

## What you'll learn

- How to use aggregate functions (`COUNT`, `SUM`, `AVG`, `MIN`, `MAX`) on columns or all rows at once.
- How to group rows by a shared property using `GROUP BY` — every unique key becomes one output row.
- The difference between `WHERE` (filters rows *before* grouping) and `HAVING` (filters groups *after* aggregation).
- Why `COUNT(*)` counts every row while `COUNT(col)` skips NULLs — and why that matters for employee supervisors.

## Prerequisites

You need **Module 04 — Changing Data & NULLs** completed, plus a running `shopdb` database with the café's tables seeded. If you haven't done that yet:

```bash
make setup && make up && make seed        # once, if you haven't already
```

## What you'll run / build

You'll execute a series of read-only aggregation queries against the `shopdb` café schema — exactly 10 tables, with `products` holding 10 rows and `orders` holding 8. The module's runnable artefact is in `examples/01-aggregate.sql`.

## How to run it

```bash
python3 dbctl.py sql --file modules/05-aggregation/examples/01-aggregate.sql
```

## This folder

| File | What it is |
| --- | --- |
| `notes.md` | Concept explanation, a worked example, and the vocabulary to remember. |
| `examples/01-aggregate.sql` | Runnable script: aggregate functions, grouping, HAVING, and subqueries against `shopdb`. |
| `exercises/README.md` | Self-challenge tasks with goals, hints, and verification commands. |
| `solutions/01-exercises.sql` | Runnable solutions so you can compare after trying. |
| `checklist.md` | An "I can…" self-check for the skills in this module. |
| `assets/group-pipeline.md` | A diagram of how SQL aggregation clauses are evaluated (FROM → WHERE → GROUP BY → HAVING). |

## Next

→ Module 06 — Joins (`JOIN`, anti-joins, cross joins). Back to the [syllabus](../../SYLLABUS.md).
