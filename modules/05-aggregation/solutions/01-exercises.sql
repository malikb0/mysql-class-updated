-- Read-only aggregation solutions on `shopdb`.
-- Run with:  python3 dbctl.py sql --file modules/05-aggregation/solutions/01-exercises.sql
-- Nothing here changes data — every statement is a SELECT.

-- Task 1 — Count all products in the catalog
SELECT COUNT(*) AS products FROM products;

-- Task 2 — Per-category product counts and average price (rounded to cents)
SELECT category_id, COUNT(*) AS n, ROUND(AVG(unit_price), 2) AS avg_price
FROM products GROUP BY category_id ORDER BY category_id;

-- Task 3 — Categories with at least three products (HAVING filters groups after aggregation)
SELECT category_id, COUNT(*) AS n FROM products GROUP BY category_id HAVING COUNT(*) >= 3 ORDER BY category_id;

-- Task 4a — Order statuses by frequency, most common first; ties follow the ENUM's declaration order
SELECT status, COUNT(*) AS n FROM orders GROUP BY status ORDER BY n DESC, status;

-- Task 4b — Employee supervisor count gap: total rows vs. non-null supervisors
SELECT COUNT(*) AS all_rows, COUNT(supervisor_id) AS non_null_supervisors
FROM employees;