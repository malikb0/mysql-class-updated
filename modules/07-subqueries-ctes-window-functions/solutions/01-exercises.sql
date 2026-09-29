-- Module 07 — Subqueries, CTEs & Window Functions — Solutions
-- Run: python3 dbctl.py sql --file modules/07-subqueries-ctes-window-functions/solutions/01-exercises.sql

-- Task 1 — products above the average price (expect 5 rows)
SELECT name, unit_price FROM products
WHERE unit_price > (SELECT AVG(unit_price) FROM products)
ORDER BY unit_price DESC;

-- Task 2 — customers who bought a Merch product (category_id = 4) (expect 3 rows: Bilal, Dana, Fatima)
SELECT DISTINCT p.first_name, p.last_name
FROM customers c
JOIN persons p ON c.person_id = p.person_id
WHERE EXISTS (
  SELECT 1 FROM orders o
  JOIN order_items oi ON o.order_id = oi.order_id
  JOIN products pr ON oi.product_id = pr.product_id
  WHERE o.customer_id = c.customer_id AND pr.category_id = 4
)
ORDER BY p.first_name;

-- Task 3 — customers with no cancelled order (expect 5 rows)
SELECT DISTINCT p.first_name, p.last_name
FROM customers c
JOIN persons p ON c.person_id = p.person_id
WHERE NOT EXISTS (
  SELECT 1 FROM orders o WHERE o.customer_id = c.customer_id AND o.status = 'cancelled'
)
ORDER BY p.first_name;

-- Task 4 — each order's total, ranked highest first (expect 8 rows; order 7 is rank 1)
WITH ordered_totals AS (
  SELECT o.order_id, SUM(oi.quantity * oi.unit_price) AS total
  FROM orders o JOIN order_items oi ON oi.order_id = o.order_id
  GROUP BY o.order_id
)
SELECT order_id, total, RANK() OVER (ORDER BY total DESC) AS rank_num
FROM ordered_totals
ORDER BY rank_num;
