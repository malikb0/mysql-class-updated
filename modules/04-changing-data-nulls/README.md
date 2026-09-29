# Module 04 — Changing Data & NULLs

> **Level:** L1 · **Prereqs:** Module 03 · **Time:** ~2 h · **Original class(es):** Class 3, 5

## Why this module

You've learned how to ask questions of the database. Now cafés need more than reading: prices shift, orders get cancelled, staff gets reorganised. This module teaches `UPDATE` and `DELETE` — the two statements that change data — plus **NULL**, the special marker meaning "unknown" rather than zero or empty string. By the end you can change a row with `UPDATE`, remove a row with `DELETE`, always filter with `WHERE`, and explain why `= NULL` never matches while `IS NULL` does.

## What you'll learn

- How to modify existing rows with `UPDATE`: pick rows with `WHERE`, then set new values on those rows.
- How to remove rows entirely with `DELETE`.
- The three-valued logic of SQL: **TRUE**, **FALSE**, and **UNKNOWN** — why `= NULL` never matches while `IS NULL` does.
- How arithmetic propagates NULL (any expression involving a NULL evaluates to NULL), and how `COALESCE` gives you a safe fallback.

## Prerequisites

You need **Module 03 — Querying: SELECT, Filter, Sort** completed, plus a running `shopdb` database with the café's tables seeded. If you haven't done that yet:

```bash
make setup && make up && make seed        # once, if you haven't already
```

## What you'll run / build

You'll execute a series of write queries against the `shopdb` café schema — exactly 10 tables. The module's runnable artefact is in `examples/01-update-delete-null.sql`. The script is net-neutral: it creates a practice table, does its work, then drops it at the end so the table count returns to 10.

## How to run it

```bash
python3 dbctl.py sql --file modules/04-changing-data-nulls/examples/01-update-delete-null.sql
```

## This folder

| File | What it is |
| --- | --- |
| `notes.md` | Concept explanation, a worked example, and the vocabulary to remember. |
| `assets/three-valued-logic.md` | Diagram: how `WHERE` treats NULL (TRUE / FALSE / UNKNOWN). |
| `examples/01-update-delete-null.sql` | Runnable script: update prices, fill NULLs, delete vegan rows against `shopdb`. |
| `exercises/README.md` | Self-challenge tasks with goals, hints, and verification commands. |
| `solutions/01-exercises.sql` | Runnable solutions so you can compare after trying. |
| `checklist.md` | An "I can…" self-check for the skills in this module — test yourself when you're done. |

## Next

→ Module 05 — Aggregation & Grouping (`COUNT`, `SUM`, `GROUP BY`). Back to the [syllabus](../../SYLLABUS.md).
