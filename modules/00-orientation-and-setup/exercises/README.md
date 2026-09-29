# Module 00 — Orientation & Setup · Exercises

Each task: **goal → hint → verify**. Solutions live in [`../solutions/01-exercises.sql`](../solutions/01-exercises.sql) — try first!

## Task 1 — Count the products
**Goal:** Count how many products the shop sells.
**Hint:** `COUNT(*)` counts rows.
**Verify:** `SELECT COUNT(*) FROM products;` — expect **10**.

## Task 2 — List the categories
**Goal:** List every category name, in id order.
**Hint:** one column, `ORDER BY category_id`.
**Verify:** expect **4** rows: Coffee, Tea, Bakery, Merch.

## Task 3 — The most recent orders
**Goal:** Show the 3 most recent orders (id, date, status).
**Hint:** `ORDER BY order_date DESC LIMIT 3`.
**Verify:** expect **3** rows, newest first; the top row is order **8** (`shipped`).

## Task 4 — Where are the stores?
**Goal:** List each store's name and city.
**Hint:** pick two columns from `stores`.
**Verify:** expect **2** rows: Downtown (Portland) and Riverside (Austin).

## How to run your answers

```bash
make sql FILE=modules/00-orientation-and-setup/solutions/01-exercises.sql
```

Without `make`, run `python dbctl.py sql --file modules/00-orientation-and-setup/solutions/01-exercises.sql`.

> 💡 Aha: every task here used the same `SELECT` you met in `notes.md` — you already know more than you think.