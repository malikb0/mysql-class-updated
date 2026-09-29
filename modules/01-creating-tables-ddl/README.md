# Module 01 — Creating Tables (DDL)

> **Level:** L1 · **Prereqs:** Module 00 · **Time:** ~2 h · **Original class(es):** 1–4, 7

## Why this module

Before you can store data in a database, you need tables. This module teaches the four DDL commands that build and shape them: `CREATE`, `ALTER`, `DROP`, and `TRUNCATE`. You'll also learn how to inspect what MySQL sees (`DESCRIBE`) and move columns around when your design evolves.

## What you'll learn

- The difference between **DDL** (data definition language) and DML, and why schema changes are special.
- How to `CREATE TABLE` with a primary key, column types, constraints, and defaults.
- How to use `DESCRIBE` to inspect what MySQL actually stored.
- When to use `ALTER TABLE`: adding columns, renaming them, repositioning them, changing types, or dropping them.
- The difference between `DROP` (gone forever) and `TRUNCATE` (empty but intact).

## What you'll run / build

You'll create a table called `practice_products`, inspect it, and use DDL commands to evolve the schema — adding columns, renaming one, moving another, and cleaning up. The module's runnable artefact is in `examples/01-create-a-table.sql`.

## How to run it

> 🎯 Goal: create a table from scratch, inspect it with `DESCRIBE`, then alter it several times without breaking the database.

```bash
make setup && make up && make seed        # once, if you haven't already
make sql FILE=modules/01-creating-tables-ddl/examples/01-create-a-table.sql
```

If you don't have `make`, use `python dbctl.py` with the same target names.

## This folder

| File | What it is |
| --- | --- |
| `notes.md` | Concept explanation, a worked example, and the vocabulary to remember. |
| `examples/` | Runnable `.sql` files, numbered in the order you should try them. |
| `exercises/` | Tasks with goals, hints, and a way to verify your answer. |
| `solutions/` | Runnable solutions so you can compare after trying. |
| `checklist.md` | An "I can…" self-check for the skills in this module. |
| `assets/` | Diagrams that make the ideas visual. |

## Next

→ Module 02 — Loading Data. Back to the [syllabus](../../SYLLABUS.md).
