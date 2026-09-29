# Module 03 — Querying: SELECT, Filter, Sort · Exercises

Each task: **goal → hint → verify**. Solutions live in `../solutions/` (try first!).

## Task 1 — Filter with a comparison operator
**Goal:** List all products whose `unit_price` is less than $10.00, sorted from cheapest to most expensive.
**Hint:** Use `WHERE unit_price < 10.00 ORDER BY unit_price ASC;`. Remember that MySQL evaluates `WHERE` before `ORDER BY`.
**Verify:** The query returns exactly 5 rows:
```sql
SELECT COUNT(*) FROM products WHERE unit_price < 10.00;   -- expect 5
```

## Task 2 — Pattern match with LIKE
**Goal:** Find every product whose name begins with the letter `C`.
**Hint:** Use `WHERE name LIKE 'C%'` — `%` is a wildcard that matches any trailing characters (try replacing it with `_` and see what breaks).
**Verify:** The count should be 3:
```sql
SELECT COUNT(*) FROM products WHERE name LIKE 'C%';   -- expect 3
```

## Task 3 — List + range filter
**Goal:** (a) Show every order whose `status = 'paid'`. (b) Show orders placed between 2024-01-07 and 2024-01-10.
**Hint:** Use `WHERE status = 'paid'` for part (a), and `WHERE order_date BETWEEN '2024-01-07' AND '2024-01-10 23:59:59'` for part (b). The `BETWEEN` value for the end date must include hours/seconds to cover the entire last day.
**Verify:** Both queries return exactly 4 rows:
```sql
SELECT COUNT(*) FROM orders WHERE status = 'paid';               -- expect 4
SELECT COUNT(*) FROM orders WHERE order_date BETWEEN '2024-01-07' AND '2024-01-10 23:59:59';   -- expect 4
```

## Task 4 — Sort + trim, and DISTINCT
**Goal:** (a) List the three most expensive products (`ORDER BY unit_price DESC LIMIT 3`). (b) Show every distinct order status that has appeared in the `orders` table.
**Hint:** For part (a), combine `WHERE is_active = TRUE`, `ORDER BY unit_price DESC`, and `LIMIT 3`. For part (b), use `SELECT DISTINCT status FROM orders ORDER BY status;`. Remember: `DISTINCT` returns one row per unique value — it does **not** aggregate.
**Verify:** The top row of part (a) is Tote Bag / 18.00; the count from part (b) is 4:
```sql
SELECT COUNT(DISTINCT status) FROM orders;   -- expect 4
```

> Try each task first, then compare your answer with `../solutions/01-exercises.sql`.