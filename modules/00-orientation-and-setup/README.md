# Module 00 — Orientation & Setup

> **Level:** L0 · **Prereqs:** none · **Time:** ~2 h · **Original class(es):** 1

## Why this module

Welcome! Over this course you'll get to know `shopdb`, a small café database of drinks, pastries, and merch — plus the customers, orders, and staff behind them. By the end of this module you'll have run your very first query against it.

## What you'll learn

- What a **relational database** actually is, and why tables with rows and columns are useful.
- How to run MySQL 8 locally with **Docker Compose**.
- How to **connect** to the running server from your terminal.
- How to read a table and run your first `SELECT` query.

## What you'll run / build

You'll run the numbered query set in `examples/01-first-queries.sql` against the freshly seeded `shopdb`.

## How to run it

> 🎯 Goal: bring up MySQL, load `shopdb`, and run your first queries without touching the classroom sandbox.

```bash
make setup && make up && make seed
make sql FILE=modules/00-orientation-and-setup/examples/01-first-queries.sql
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

→ Module 01 — Creating Tables (DDL). Back to the [syllabus](../../SYLLABUS.md).
