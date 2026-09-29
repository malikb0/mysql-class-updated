# Module 11 — Keys, Constraints & Relationships

> **Level:** L3 · **Prereqs:** Module 10 (Data Modeling & Normalization) · **Time:** ~2h · **Original class(es):** Class 13, 14

## Why this module

You've built tables and loaded data. Now you need to tell the database *what is allowed* — which columns must be unique, which values can't be null, which child rows should die when a parent does. Without these rules your schema is just a loose collection of tables; with them it becomes a contract that guarantees data integrity even before any application layer checks its input.

This module covers the full family: primary keys, unique constraints, check expressions, foreign keys with cascade and restrict actions, and reading those rules back from `information_schema`. You'll also learn how to diagnose constraint violations — because seeing an error message is the fastest way to know what went wrong.

## What you'll learn

- Choose the right key/constraint: `PRIMARY KEY`, `UNIQUE`, `NOT NULL`, `DEFAULT`, `CHECK`, `FOREIGN KEY`
- Control what happens on delete/update with **`ON DELETE` / `ON UPDATE`** actions (`CASCADE`, `RESTRICT`, `SET NULL`)
- **Read the constraints a database enforces** from `information_schema`
- Diagnose a constraint violation from its error message

## Prerequisites

You need MySQL 8 running locally. Set up with:

```bash
make setup
make up
make seed
```

This creates the `shopdb` database and seeds it with 12 persons, 6 customers, 2 stores, 5 employees, 4 categories, 10 products, 8 orders, 14 order items, and 6 payments. You don't need to connect by hand — `dbctl.py` talks to the running container for you.

## What you'll run / build

Build a small parent/child pair with every key kind, read its constraints from `information_schema`, and watch `ON DELETE CASCADE` fire — then drop everything so the script is net-neutral.

## How to run it

```bash
python3 dbctl.py sql --file examples/01-keys-and-constraints.sql
```

This runs the full example script against your local `shopdb`. Each step is commented with what you should see.

## This folder

| File | Description |
|---|---|
| `notes.md` | Concepts, worked example, and common errors |
| `assets/constraint-map.md` | Constraint family diagram (Mermaid) |
| `examples/01-keys-and-constraints.sql` | Runnable example script |
| `exercises/README.md` | Practice exercises (try before looking at solutions!) |
| `solutions/01-exercises.sql` | Solutions — do the exercises yourself first |
| `checklist.md` | Self-assessment checklist for this module |

## Next

[Module 12 — Indexes & Views](../../SYLLABUS.md) lists every module.
