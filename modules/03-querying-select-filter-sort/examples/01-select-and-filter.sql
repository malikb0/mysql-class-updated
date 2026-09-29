-- Read-only tour: querying `shopdb` by telling the story of a small café.
-- Run with:  python3 dbctl.py sql --file modules/03-querying-select-filter-sort/examples/01-select-and-filter.sql
-- Nothing here changes data — every statement is a SELECT.

-- Step 1 — SELECT specific columns: list the active products, sorted by category then name
SELECT product_id, name, unit_price FROM products WHERE is_active = TRUE ORDER BY category_id, name ASC;

-- Step 2 — WHERE with a comparison + ORDER BY: premium items over $10, most expensive first
SELECT product_id, name, sku, unit_price FROM products WHERE unit_price > 10.00 ORDER BY unit_price DESC;

-- Step 3 — WHERE with AND/OR: coffee or tea items that are active, or any even-numbered product
SELECT product_id, name, category_id FROM products
WHERE (category_id IN (1, 2) AND is_active = TRUE) OR (product_id % 2 = 0);

-- Step 4 — WHERE with LIKE: partial name match (no product contains "Blue" in this dataset)
SELECT product_id, name FROM products WHERE name LIKE '%Tea%' OR name LIKE '%Blue%';

-- Step 5 — WHERE with IN (...): pick from a list of order statuses
SELECT order_id, customer_id, status FROM orders WHERE status IN ('pending', 'cancelled');

-- Step 6 — WHERE with BETWEEN: orders placed 2024-01-07 through 2024-01-10.
--   `order_date` is a DATETIME, so end the range at 23:59:59 to include the whole last day.
SELECT order_id, customer_id, store_id, order_date FROM orders
WHERE order_date BETWEEN '2024-01-07' AND '2024-01-10 23:59:59';

-- Step 7 — WHERE with IS NULL: store managers who report to no one
SELECT employee_id, store_id, role FROM employees WHERE supervisor_id IS NULL;

-- Step 8 — ORDER BY two keys: price (highest first), then name alphabetically on ties
SELECT product_id, name, unit_price FROM products ORDER BY unit_price DESC, name ASC;

-- Step 9 — LIMIT: the three most expensive active items
SELECT product_id, name, category_id, unit_price FROM products
WHERE is_active = TRUE ORDER BY unit_price DESC LIMIT 3;

-- Step 10 — DISTINCT: every order status that has appeared
SELECT DISTINCT status FROM orders ORDER BY status;
