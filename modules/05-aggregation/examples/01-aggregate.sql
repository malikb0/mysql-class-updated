-- Read-only aggregation examples on `shopdb`.
-- Run with:  python3 dbctl.py sql --file modules/05-aggregation/examples/01-aggregate.sql
-- Nothing here changes data — every statement is a SELECT.

-- Step 1 — total number of products in the catalog
SELECT COUNT(*) AS products FROM products;

-- Step 2 — per-category aggregates: row count, average price (rounded to cents), min and max prices
SELECT category_id,
       COUNT(*)     AS n,
       ROUND(AVG(unit_price), 2) AS avg_price,
       MIN(unit_price)   AS min_price,
       MAX(unit_price)   AS max_price
FROM products
GROUP BY category_id
ORDER BY category_id;

-- Step 3 — categories with at least three products (HAVING filters groups after aggregation)
SELECT category_id, COUNT(*) AS n FROM products GROUP BY category_id HAVING COUNT(*) >= 3 ORDER BY category_id;

-- Step 4 — order statuses and their frequencies, most common first; ties follow the status ENUM's
-- declaration order (pending → paid → shipped → cancelled), which is NOT alphabetical.
SELECT status, COUNT(*) AS n FROM orders GROUP BY status ORDER BY n DESC, status;

-- Step 5 — aggregates across line items: average quantity (rounded to three decimals), total units ordered, min/max quantities
SELECT ROUND(AVG(quantity), 3) AS avg_qty,
       SUM(quantity)           AS total_qty,
       MIN(quantity)           AS min_qty,
       MAX(quantity)           AS max_qty
FROM order_items;

-- Step 6 — COUNT(*) counts all rows; COUNT(supervisor_id) excludes NULLs (employees without supervisors)
SELECT COUNT(*)     AS all_rows,
       COUNT(supervisor_id) AS non_null_supervisors
FROM employees;

-- Step 7 — subquery: fetch the product name and price of the most expensive item in a single row
SELECT name, unit_price FROM products WHERE unit_price = (SELECT MAX(unit_price) FROM products);

-- Step 8 — GROUP BY must appear before HAVING; WHERE filters rows prior to grouping while HAVING filters groups afterward.
