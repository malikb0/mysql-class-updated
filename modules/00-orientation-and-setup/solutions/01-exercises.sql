-- Module 00 — solutions to exercises/README.md
-- Run: python dbctl.py sql --file modules/00-orientation-and-setup/solutions/01-exercises.sql

-- Task 1 — count the products (expect 10)
SELECT COUNT(*) FROM products;

-- Task 2 — list the categories (expect 4: Coffee, Tea, Bakery, Merch)
SELECT name FROM categories ORDER BY category_id;

-- Task 3 — the 3 most recent orders (newest first)
SELECT order_id, order_date, status FROM orders ORDER BY order_date DESC LIMIT 3;

-- Task 4 — store name and city (expect 2 rows)
SELECT name, city FROM stores ORDER BY store_id;