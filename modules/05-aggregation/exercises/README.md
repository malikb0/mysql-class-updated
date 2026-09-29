# Module 05 — Aggregation & Grouping · Exercises

Each task: **goal → hint → verify**. Solutions live in `../solutions/` (try first!).

## Task 1 — Count all products in the catalog
**Goal:** Find out how many products are currently listed in the café's inventory.
**Hint:** Use `SELECT COUNT(*) FROM products;`. Remember that aggregate functions collapse rows into single numbers — this query returns exactly one row with one column.
**Verify:** The count should be 10:
```sql
SELECT COUNT(*) AS products FROM products;   -- expect 10
```

## Task 2 — Per-category product counts and average price (rounded to cents)
**Goal:** For each `category_id`, show the number of products in that category and the average `unit_price` rounded to two decimal places, sorted by `category_id`.
**Hint:** Use `GROUP BY category_id` with `COUNT(*) AS n` and `ROUND(AVG(unit_price), 2) AS avg_price`. Remember: MySQL requires every non-aggregate column in SELECT to appear in GROUP BY — otherwise you'll get an `ERROR 1140`. Also remember that `AVG` ignores NULLs, so if any product has a missing price it won't affect the average.
**Verify:** The query should return exactly four rows:

| category_id | n | avg_price |
|-------------|---|-----------|
| 1          | 3      | 11.25     |
| 2          | 3      | 8.50      |
| 3          | 2      | 3.50      |
| 4          | 2      | 16.00     |

## Task 3 — Categories with at least three products (HAVING)
**Goal:** Keep only the categories that have **three or more** products, and show their counts sorted by `category_id`. Use `HAVING` rather than `WHERE`.
**Hint:** `HAVING` filters groups *after* aggregation — it can reference aggregate results like `COUNT(*)`, which is why it's the right choice here. If you put this condition in `WHERE`, MySQL would reject it because `COUNT(*)` isn't available until after grouping.
**Verify:** Only categories 1 and 2 should be returned (each with a count of 3):
```sql
SELECT category_id, COUNT(*) AS n FROM products GROUP BY category_id HAVING COUNT(*) >= 3 ORDER BY category_id;   -- expect 2 rows: categories 1 and 2
```

## Task 4 — Order statuses by frequency, plus the employee supervisor count gap
**Goal:** (a) Show how many orders there are per `status`, sorted from most common to least; break ties by the status ENUM's declaration order. (b) On the `employees` table, show the difference between `COUNT(*)` and `COUNT(supervisor_id)` — one is 5, the other is 4.
**Hint:** For part (a), use `GROUP BY status ORDER BY n DESC, status;`. The `status` column is an ENUM (`'pending','paid','shipped','cancelled'`) so ordering by it uses the declaration order — not alphabetical. That's why "cancelled" sorts last even though 'c' < 'p'. For part (b), use `SELECT COUNT(*) AS all_rows, COUNT(supervisor_id) AS non_null_supervisors FROM employees;`. The difference exists because employee 1 has a NULL `supervisor_id` — it is excluded from the second count.
**Verify:** The status counts should be paid 4 · shipped 2 · pending 1 · cancelled 1, and the employee query should return all_rows = 5, non_null_supervisors = 4 (the gap of 1 is because one employee has no supervisor):
```sql
SELECT status, COUNT(*) AS n FROM orders GROUP BY status ORDER BY n DESC, status;   -- expect: paid=4, shipped=2, pending=1, cancelled=1

SELECT COUNT(*) AS all_rows, COUNT(supervisor_id) AS non_null_supervisors FROM employees;   -- expect: 5 | 4
```

> Try each task first, then compare your answer with `../solutions/01-exercises.sql`.
