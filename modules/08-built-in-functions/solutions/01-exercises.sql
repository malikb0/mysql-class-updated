-- Module 08 — Built-in Functions · Exercise solutions
-- Run with: python3 dbctl.py sql --file modules/08-built-in-functions/solutions/01-exercises.sql

-- Task 1 — Full name + email domain for every person
SELECT person_id,
       CONCAT(first_name, ' ', last_name) AS full_name,
       SUBSTRING_INDEX(email, '@', -1) AS domain
FROM persons
ORDER BY person_id;

-- Task 2 — Price-band counts across all products
SELECT CASE WHEN unit_price < 5.00 THEN 'budget'
            WHEN unit_price < 12.00 THEN 'mid'
            ELSE 'premium' END AS price_band,
       COUNT(*) AS products
FROM products
GROUP BY price_band
ORDER BY price_band;

-- Task 3 — The weekday of each order
SELECT order_id,
       DAYNAME(order_date) AS weekday
FROM orders
ORDER BY order_id;

-- Task 4 — Comma-separated product list per category
SELECT c.name AS category,
       GROUP_CONCAT(pr.name ORDER BY pr.name SEPARATOR ', ') AS products
FROM categories c
JOIN products pr ON pr.category_id = c.category_id
GROUP BY c.category_id, c.name
ORDER BY c.category_id;
