-- Module 06 — Joins · Solutions for exercises/README.md
-- Run: python3 dbctl.py sql --file modules/06-joins/solutions/01-exercises.sql

-- Task 1 — every product with its category name (expect 10 rows)
SELECT p.name AS product, p.unit_price, c.name AS category
FROM products p JOIN categories c ON c.category_id = p.category_id
ORDER BY p.name;

-- Task 2 — every person and their city (expect 12 rows)
SELECT p.first_name, a.city
FROM persons p LEFT JOIN addresses a ON a.person_id = p.person_id
ORDER BY p.person_id;

-- Task 3 — employees who manage nobody (expect 3 rows: employees 2, 4, 5)
SELECT e.employee_id, p.first_name, e.role
FROM employees e
JOIN persons p ON p.person_id = e.person_id
LEFT JOIN employees sub ON sub.supervisor_id = e.employee_id
WHERE sub.employee_id IS NULL
ORDER BY e.employee_id;

-- Task 4 — how many line items each order has (expect 8 rows)
SELECT o.order_id, COUNT(oi.order_item_id) AS line_items
FROM orders o
LEFT JOIN order_items oi ON oi.order_id = o.order_id
GROUP BY o.order_id
ORDER BY o.order_id;
