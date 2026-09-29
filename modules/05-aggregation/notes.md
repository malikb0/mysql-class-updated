# Module 05 — Aggregation & Grouping · Notes

> Run the commands as you read. The worked example is the same one the checklist asks you to repeat.

## 1. Why this matters

Aisha orders a double espresso every time and wants it logged. Bilal needs to know who his regulars are, what's in stock, and when each product launched.

You already learned how to filter rows (`WHERE`) and sort them (`ORDER BY`). But sometimes you don't want individual rows — you want *answers* about the whole table: "how many products does this café have?", "what's the average price of tea items?", "which categories are overstock?".

Aggregation turns many rows into a few answers. Every query in this module is **read-only** — `SELECT` only, never touching data.

## 2. The concept

An **aggregate function** takes a column (or all columns) and collapses it into a single number: the count, sum, average, minimum, or maximum.

```sql
SELECT COUNT(*) FROM products;
-- Returns one row with one column: 10
```

To group rows by some shared property — say, category — you use `GROUP BY`. MySQL then applies the aggregate function *per group*, producing one output row per unique grouping key.

The clause order for aggregation is slightly different from plain SELECT:

`FROM → WHERE → GROUP BY → HAVING → SELECT → ORDER BY`

**Where vs Having:**
- **WHERE** filters rows *before* grouping — it decides which rows enter the groups at all.
- **HAVING** filters groups *after* aggregation — it decides which output rows survive.

```sql
-- WHERE: filter rows first, then count what remains per category
SELECT category_id, COUNT(*) AS n FROM products
WHERE is_active = TRUE GROUP BY category_id;

-- HAVING: count all, then keep only categories with >= 3 products
SELECT category_id, COUNT(*) AS n FROM products
GROUP BY category_id HAVING COUNT(*) >= 3;
```

**Counting:** `COUNT(*)` counts every row in a group. `COUNT(supervisor_id)` skips rows where that column is NULL — because "unknown" isn't a supervisor you can count. This distinction matters: it's why `SELECT COUNT(*) FROM employees` (5) differs from `SELECT COUNT(supervisor_id) FROM employees` (4).

**Vocabulary:** `aggregate function` — a SQL function (`COUNT`, `SUM`, `AVG`, `MIN`, `MAX`) that collapses many values into one · **grouping key** — the column or expression you group by; every unique value becomes one output row · `GROUP BY` — the clause that defines grouping keys · `HAVING` — filters groups after aggregation, like `WHERE` but for rows of a grouped result · `only_full_group_by` — MySQL's default setting that requires every non-aggregate column in SELECT to appear in GROUP BY.

## 3. Worked example (do this)

**Starting state:** The `shopdb` database has exactly 10 tables. The `products` table has 10 rows across four categories; the `orders` table has 8 rows with statuses pending, paid, shipped, and cancelled; the `order_items` table has 14 line items totalling 20 units (quantities from 1 to 3); the `employees` table has 5 rows where employee 1's `supervisor_id` is NULL.

**Goal:** Run a read-only tour of aggregation queries that tell you about the café's products, orders, and employees — without changing anything.

### Step 1 — COUNT(*): how many products in the catalog

```sql
SELECT COUNT(*) AS products FROM products;
```

| products |
|----------|
| 10       |

> 🎯 Goal: a single number — the total product count, regardless of category or price.

### Step 2 — Per-category aggregates: row count, average price (rounded to cents), min and max prices

```sql
SELECT category_id,
       COUNT(*)     AS n,
       ROUND(AVG(unit_price), 2) AS avg_price,
       MIN(unit_price)   AS min_price,
       MAX(unit_price)   AS max_price
FROM products
GROUP BY category_id
ORDER BY category_id;
```

| category_id | n | avg_price | min_price | max_price |
|-------------|---|-----------|-----------|----------|
| 1          | 3      | 11.25     | 10.00    | 12.50   |
| 2          | 3      | 8.50      | 8.00     | 9.00    |
| 3          | 2      | 3.50      | 3.25     | 3.75    |
| 4          | 2      | 16.00     | 14.00    | 18.00   |

> 🎯 Goal: for each category, the number of products and the price range — useful for spotting outliers (category 4's max of $18 is higher than any other category).

### Step 3 — HAVING: categories with at least three products

```sql
SELECT category_id, COUNT(*) AS n FROM products GROUP BY category_id HAVING COUNT(*) >= 3 ORDER BY category_id;
```

| category_id | n |
|-------------|---|
| 1          | 3   |
| 2          | 3   |

> ⚠️ Gotcha: `HAVING` runs *after* the aggregation — it filters output rows, not input ones. If you put this condition in `WHERE`, MySQL would reject it because `COUNT(*)` isn't available there.

### Step 4 — Order statuses and their frequencies, most common first; ties follow the status ENUM's declaration order (pending → paid → shipped → cancelled), which is NOT alphabetical.

```sql
SELECT status, COUNT(*) AS n FROM orders GROUP BY status ORDER BY n DESC, status;
```

| status     | n |
|------------|--|
| paid       | 4   |
| shipped    | 2   |
| pending  | 1   |
| cancelled | 1   |

> 🎯 Goal: see which statuses are most common. The `status` column is an ENUM (`'pending','paid','shipped','cancelled'`), so ordering by it uses the declaration (ordinal) order — not alphabetical. That's why "cancelled" sorts last even though 'c' < 'p'.

### Step 5 — Aggregates across line items: average quantity, total units ordered, min/max quantities

```sql
SELECT ROUND(AVG(quantity), 3) AS avg_qty,
       SUM(quantity)           AS total_qty,
       MIN(quantity)           AS min_qty,
       MAX(quantity)           AS max_qty
FROM order_items;
```

| avg_qty | total_qty | min_qty | max_qty |
|---------|----------|---------|---------|
| 1.429    | 20      | 1     | 3      |

> 🎯 Goal: the average quantity per line item is about 1.4 — so most orders are for one or two items, with a few three-item lines. The total across all order items is exactly 20 units.

### Step 6 — COUNT(*) vs COUNT(supervisor_id): counting employees with and without supervisors

```sql
SELECT COUNT(*)     AS all_rows,
       COUNT(supervisor_id) AS non_null_supervisors
FROM employees;
```

| all_rows | non_null_supervisors |
|----------|----------------------|
| 5        | 4                  |

> ⚠️ Gotcha: `COUNT(*)` counts every row (5). `COUNT(supervisor_id)` skips the one NULL — employee 1 reports to no supervisor, so it's excluded from the count. This is why the numbers differ and why `COUNT(col)` can be a useful safety net when you're unsure about NULLs.

### Step 7 — Subquery: fetch the product name and price of the most expensive item in a single row

```sql
SELECT name, unit_price FROM products WHERE unit_price = (SELECT MAX(unit_price) FROM products);
```

| name      | unit_price |
|-----------|----------|
| Tote Bag    | 18.00   |

> 💡 Aha: the inner `SELECT MAX(unit_price)` runs first, returns 18.00, then the outer query finds which product has that price. Subqueries like this are powerful but can be slow on huge tables — later modules cover alternatives.

## 4. How it works

MySQL evaluates aggregation clauses in this logical order:

1. **FROM** — load the table(s).
2. **WHERE** — filter rows *before* grouping. Rows that fail the condition never enter any group.
3. **GROUP BY** — partition the remaining rows into groups by their key values. Each unique value becomes one group.
4. **HAVING** — filter groups *after* aggregation. Only groups whose aggregate satisfies the HAVING expression appear in the output.
5. **SELECT** — apply aggregate functions to each group (COUNT, SUM, AVG, MIN, MAX) and pick which columns/expressions to keep. Non-aggregate columns must either be grouping keys or wrapped in an aggregate — otherwise MySQL throws `ERROR 1140`.
6. **ORDER BY** — sort the final output rows.

### Why non-grouped columns are illegal

`SELECT category_id, COUNT(*) FROM products;` fails with:

```text
ERROR 1140 (42000): In aggregated query without GROUP BY, expression #1 of SELECT list contains nonaggregated column 'shopdb.products.category_id'; this is incompatible with sql_mode=only_full_group_by
```

MySQL doesn't know *which* `category_id` to pick from the group — there are many. It requires every non-aggregate column in SELECT to appear in GROUP BY, or be wrapped in an aggregate function. The fix is adding `GROUP BY category_id`.

### Where vs Having: not interchangeable

```sql
-- WHERE filters rows BEFORE grouping
SELECT category_id, COUNT(*) AS n FROM products
WHERE unit_price > 10.00 GROUP BY category_id;

-- HAVING filters groups AFTER grouping
SELECT category_id, COUNT(*) AS n FROM products
GROUP BY category_id HAVING COUNT(*) >= 3;
```

`WHERE` decides which rows enter the groups at all — it can't reference aggregate results because aggregation hasn't happened yet. `HAVING` runs after every group has been collapsed into one row, so it can use `COUNT(*)`, `SUM(...)`, etc.

### COUNT(*) vs COUNT(col): NULLs matter

`COUNT(*)` counts every row regardless of column values. `COUNT(supervisor_id)` skips rows where that column is NULL — because "unknown" isn't a supervisor you can count. That's why the employees query returns 5 for `all_rows` but 4 for `non_null_supervisors`.

## 5. Common errors & fixes

| Symptom | Cause | Fix |
|---------|-------|-----|
| `ERROR 1140 (42000): In aggregated query without GROUP BY, expression #1 of SELECT list contains nonaggregated column 'shopdb.products.category_id'; this is incompatible with sql_mode=only_full_group_by` | You selected a non-grouped column alongside an aggregate. MySQL doesn't know which value to pick from the group. | Add `GROUP BY` for every non-aggregate column in SELECT: `SELECT category_id, COUNT(*) FROM products GROUP BY category_id;` |
| `ERROR 1054 (42S22): Unknown column 'price' in 'field list'` | The column is named `unit_price`, not `price`. | Check the table schema with `DESCRIBE products;` first. |
| Using `WHERE COUNT(*) >= 3` instead of `HAVING COUNT(*) >= 3` | `COUNT(*)` isn't available in WHERE because aggregation hasn't happened yet. MySQL rejects it. | Move the condition to HAVING: `SELECT category_id, COUNT(*) AS n FROM products GROUP BY category_id HAVING COUNT(*) >= 3;` |
| Forgetting `GROUP BY` entirely on a multi-column SELECT with aggregates | MySQL throws ERROR 1140 because non-grouped columns are illegal. | Add the grouping keys you intended to group by. |

## 6. Try it yourself

The exercises are in `exercises/`. Open `README.md` there and pick one challenge.

**Success looks like:**
- You can use aggregate functions (`COUNT`, `SUM`, `AVG`, `MIN`, `MAX`) on columns or all rows.
- You understand grouping keys via `GROUP BY` — every unique value becomes one output row.
- You know the difference between `WHERE` (pre-group) and `HAVING` (post-group).
- You understand why `COUNT(*)` counts everything while `COUNT(col)` skips NULLs.

> 🧪 Try it: in Step 4, remove `ORDER BY n DESC, status` and watch the rows reorder — without explicit ordering, MySQL returns groups in whatever order the engine processes them. Add a different sort key (like `status ASC`) to see how ties behave.

## 7. Going deeper (L3/L4)

**Edge cases:**
- **NULLs in SUM/AVG**: aggregate functions ignore NULLs in the column — `SUM(col)` adds only the non-NULL values, and `AVG(col)` divides by the number of non-NULL values, so NULLs neither add to the total nor drag the average down.
- **GROUP BY with expressions**: you can group by computed values: `SELECT YEAR(order_date) AS year, COUNT(*) FROM orders GROUP BY YEAR(order_date);` groups orders by the year they were placed.
- **HAVING vs WHERE performance**: they are not interchangeable — `WHERE` reduces the rows that enter the groups, so filtering there first is usually cheaper than grouping every row and discarding groups in `HAVING`. An index on the grouping column helps most.

**Aggregate subqueries:**
Subqueries like `WHERE unit_price = (SELECT MAX(unit_price) FROM products)` are powerful but can be inefficient on large tables — the engine must compute the inner aggregate before it can compare. Alternatives include joins and window functions (`ROW_NUMBER() OVER (ORDER BY ...)`), which you'll meet in later modules.

**COUNT(DISTINCT …):**
`SELECT COUNT(DISTINCT category_id) FROM products;` counts unique categories (4), skipping duplicates. This is useful when you need cardinality — the number of distinct values in a column — but it's slower than `COUNT(*)` because MySQL must track every value seen so far.

**Real systems:**
In production cafés, aggregation queries run against millions of orders and line items. The grouping key (e.g., `order_date`) is indexed to avoid full table scans; the HAVING condition narrows results before sorting. Modules 12 (Indexes & Views) covers how MySQL speeds up these operations with indexes.

## References

- [MySQL Aggregate Functions](https://dev.mysql.com/doc/refman/8.0/en/aggregation-functions.html)
- [MySQL GROUP BY](https://dev.mysql.com/doc/refman/8.0/en/group-by-handling.html)
- Back to the syllabus: [`../../SYLLABUS.md`](../../SYLLABUS.md)
