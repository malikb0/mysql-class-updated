# Module 07 — Subqueries, CTEs & Window Functions

> **Level:** L2 · **Prereqs:** Module 06 · **Time:** ~3 h · **Original class(es):** 6, 13 (extended)

## Why this module

Aisha wants a list of products that cost more than the average price — but she doesn't want the average hard-coded in her query; if prices change tomorrow, she shouldn't have to edit anything. Or maybe she needs to find every customer who bought a "Merch" product (category 4), or identify employees at the bottom of the hierarchy with no supervisor above them.

These questions can't be answered by a single `SELECT`. You need either a subquery — a query nested inside another query, letting the inner one compute something the outer one then filters on; a CTE (Common Table Expression) — a named pipeline defined with `WITH name AS (…)`, referenced by name in your main query as if it were a real table; or a window function — a calculation that runs *across* rows while keeping every row visible, unlike `GROUP BY` which collapses many rows into one.

## What you'll learn

- Write scalar subqueries (`WHERE unit_price > (SELECT AVG(unit_price) FROM products)`), `IN`, `EXISTS`/`NOT EXISTS`, and correlated subqueries that reference an outer table alias.
- Build CTEs with `WITH … AS` including a **recursive** CTE for the employee hierarchy traversal.
- Use window functions (`ROW_NUMBER`, `RANK` / `DENSE_RANK`, running `SUM() OVER`, `LAG`) with `PARTITION BY` and `ORDER BY`.
- Understand how MySQL evaluates each tool — subqueries (inner first, or per-row when correlated), CTEs (evaluated once as named temporary tables), and window functions (spread across rows without collapsing data).

## Prerequisites

You need Module 06 done and `shopdb` running/seeded:

```bash
make setup && make up && make seed        # once, if you haven't already
```

## What you'll run / build

A read-only tour of subqueries, CTEs, and window functions over the café data (`products` 10 rows, `orders` 8, `order_items` 14, `employees` 5); nothing is changed. The runnable walkthrough is `examples/01-subqueries-ctes-window.sql`.

## How to run it

```bash
python3 dbctl.py sql --file modules/07-subqueries-ctes-window-functions/examples/01-subqueries-ctes-window.sql
```

## This folder

| File | Description |
|---|---|
| `notes.md` | Concept explanation, a 13-step worked example, and the vocabulary to remember. |
| `examples/01-subqueries-ctes-window.sql` | Read-only script: subqueries, CTEs, and window functions against `shopdb`. |
| `exercises/README.md` | Self-challenge tasks with goals, hints, and verification commands. |
| `solutions/01-exercises.sql` | Runnable solutions so you can compare after trying. |
| `checklist.md` | An "I can…" self-check for the skills in this module. |
| `assets/window-concepts.md` | A diagram of the three tools: subquery, CTE, and window function. |

## Next

The next modules build on these tools — you'll use subqueries to filter complex joins, CTEs to structure multi-step analytics pipelines, and window functions for running totals and trend analysis in later lessons. Return to the [syllabus](../../SYLLABUS.md) when you want to see where everything fits together.
