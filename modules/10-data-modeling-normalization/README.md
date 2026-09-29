# Module 10 — Data Modeling & Normalization

> **Level:** L3 · **Prereqs:** Module 09 (Data Types & Precision) · **Time:** ~2h · **Original class(es):** new (gap; uses the `.mwb` model)

## Why this module

A flat spreadsheet looks convenient until you need to find a customer's order history or change a product price across thousands of rows. Data modeling gives you the discipline to break that spreadsheet into tables connected by relationships, and normalization tells you exactly which pieces belong where — so every piece of information lives in one place and can't get out of sync.

By the end of this module you'll be able to read any schema as a map of entities and relationships, spot the three kinds of normalization problems before they happen, and rebuild your data from scratch using joins instead of copy-paste.

## What you'll learn

- Read a schema as **entities and relationships**, and inspect the ones `shopdb` already encodes
- Recognise the three normalization problems in a flat table: **repeating groups**, **partial** and **transitive** dependencies
- Walk a table **1NF → 2NF → 3NF** and rebuild the original picture with a join
- Decide **when to denormalize** (and name the trade-off)

## Prerequisites

You need `mysql` on your machine. If you haven't set up yet:

```bash
make setup && make up && make seed
python3 dbctl.py sql --sql "SELECT COUNT(*) FROM shopdb.persons;"
```

## What you'll run / build

Normalise a flat café order table one normal form at a time, then join the 3NF model back together.

## How to run it

```bash
python3 dbctl.py sql --file examples/01-modeling-and-normalization.sql
```

The script is net-neutral — it creates and drops its own `practice_*` tables so `shopdb` stays at 10 tables after running.

## This folder

| File | Purpose |
|---|---|
| `assets/normal-forms.md` | The normalization ladder (Mermaid diagram) |
| `examples/01-modeling-and-normalization.sql` | Worked example — run it with the command above |
| `exercises/README.md` | Practice tasks to deepen your understanding |
| `checklist.md` | Self-check: can you do everything this module asks? |
| `solutions/01-exercises.sql` | Reference solutions (try exercises first!) |

## Next

[Module 11 — Keys, Constraints & Relationships](../../SYLLABUS.md)
