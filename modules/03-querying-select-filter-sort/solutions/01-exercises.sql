-- Task 1 — Filter with a comparison operator
SELECT product_id, name, sku, unit_price FROM products WHERE unit_price < 10.00 ORDER BY unit_price ASC;

-- Task 2 — Pattern match with LIKE
SELECT product_id, name, sku, unit_price FROM products WHERE name LIKE 'C%';

-- Task 3a — List orders by status filter
SELECT order_id, customer_id, store_id, order_date, status FROM orders WHERE status = 'paid';

-- Task 3b — List orders with a date range filter
SELECT order_id, customer_id, store_id, order_date, status FROM orders WHERE order_date BETWEEN '2024-01-07' AND '2024-01-10 23:59:59';

-- Task 4a — Sort and trim with LIMIT
SELECT product_id, name, sku, unit_price FROM products ORDER BY unit_price DESC LIMIT 3;

-- Task 4b — DISTINCT to find unique values
SELECT DISTINCT status FROM orders ORDER BY status;