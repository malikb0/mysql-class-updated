# Module 06 — Joins

> **Level:** L2 · **Prereqs:** Module 05 — Aggregation & Grouping · **Time:** ~2.5 h · **Original class(es):** 8, 10–12

## Why this module

The café's data is beautifully normalised: `orders` stores the customer ID and product IDs; names live in `persons`, prices in `products`. But a report that says "customer_id = 3, product_id = 1" isn't useful — you want to see *who* ordered what. Joins stitch separate tables together so every row carries both pieces of information at once.

Every join query in this module is **read-only** against the `shopdb` schema (10 tables). There's exactly one small net-neutral write: an `INSERT … SELECT` demo that creates a practice table from joined results and then drops it, leaving the database unchanged. You'll learn to join two or more tables with `JOIN … ON`, choose between inner/left/right joins, recognise an anti-join (`LEFT JOIN … WHERE key IS NULL`), use cross joins deliberately, and build self-joins (employees pointing back to supervisors).

## What you'll learn

- How to join two or more tables with `INNER JOIN` / `LEFT JOIN` / `RIGHT JOIN` on matching keys — the most common way to bring related data into one result.
- Why `INNER` drops rows that don't match everywhere, while `LEFT` keeps every row from the left table even when there's no right-side match (useful for finding missing addresses or unplaced orders).
- How to recognise and build an anti-join pattern (`LEFT JOIN … WHERE key IS NULL`) — a reliable way to find "customers with no orders" without writing subqueries.
- What `CROSS JOIN` really does (produces every pair of rows) and how to use it *deliberately* when you truly need a cartesian product, plus how to spot the common mistake where an accidental cross join explodes your result set.

## Prerequisites

You need **Module 05 — Aggregation & Grouping** completed, plus a running `shopdb` database with all 10 tables seeded. If you haven't done that yet:

```bash
make setup && make up && make seed        # once, if you haven't already
```

## What you'll run / build

You'll run a series of join queries against the `shopdb` café data — 6 customers linked to 12 persons, 8 orders, and 14 order lines linked to 10 products across four categories. The module's runnable walkthrough is `examples/01-joins.sql`: inner joins (customers with their person names, and line items with products), a left join that exposes the unmatched `NULL`s, the anti-join (people who are not customers), `CROSS JOIN`, a self-join mapping every employee to their supervisor, and a small net-neutral `INSERT … SELECT` that builds a summary table and drops it, so `shopdb` stays at exactly 10 tables.

## How to run it

```bash
python3 dbctl.py sql --file modules/06-joins/examples/01-joins.sql
```

## This folder

| File | What it is |
| --- | --- |
| `notes.md` | Concept explanation, a worked example, and the vocabulary to remember. |
| `examples/01-joins.sql` | Runnable script: inner, left, right, cross, anti- and self-joins against `shopdb`. |
| `exercises/README.md` | Self-challenge tasks with goals, hints, and verification commands. |
| `solutions/01-exercises.sql` | Runnable solutions so you can compare after trying. |
| `checklist.md` | An "I can…" self-check for the skills in this module. |
| `assets/join-types.md` | A diagram of which rows survive each kind of join. |

## Next

→ Module 07 — Subqueries, CTEs & Window Functions (`WITH`, window frames). Back to the [syllabus](../../SYLLABUS.md).