-- Module 06: Joins — examples
-- Run with: python dbctl.py sql --file modules/06-joins/examples/01-joins.sql
-- Or via make:   make sql FILE=modules/06-joins/examples/01-joins.sql

-- Step 1: INNER JOIN customers to persons (basic join)
SELECT c.customer_id, p.first_name, p.last_name, c.date_joined
FROM customers c JOIN persons p ON p.person_id = c.person_id
ORDER BY c.customer_id;

-- Step 2: Multi-table join orders → customers → persons
SELECT o.order_id,
       CONCAT(p.first_name,' ',p.last_name) AS customer,
       o.status
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id
JOIN persons p  ON p.person_id = c.person_id
ORDER BY o.order_id;

-- Step 3: Line detail — order_items joined to products (line_total = qty × price)
SELECT oi.order_item_id, oi.order_id, pr.name AS product,
       oi.quantity, oi.unit_price,
       (oi.quantity * oi.unit_price) AS line_total
FROM order_items oi JOIN products pr ON pr.product_id = oi.product_id
ORDER BY oi.order_item_id;

-- Step 4: LEFT JOIN persons to customers (shows NULLs for people who are not customers)
SELECT p.person_id, p.first_name, c.customer_id
FROM persons p LEFT JOIN customers c ON c.person_id = p.person_id
ORDER BY p.person_id;

-- Step 5: Anti-join — people who are NOT customers
SELECT p.person_id, p.first_name, p.last_name
FROM persons p LEFT JOIN customers c ON c.person_id = p.person_id
WHERE c.customer_id IS NULL
ORDER BY p.person_id;

-- Step 6: CROSS JOIN stores to categories (every pairing)
SELECT s.name AS store, c.name AS category
FROM stores s CROSS JOIN categories c
ORDER BY s.store_id, c.category_id;

-- Step 7: SELF JOIN — employees joined to their supervisor via the same table
SELECT e.employee_id,
       CONCAT(p.first_name,' ',p.last_name) AS employee,
       e.role,
       CONCAT(s.first_name,' ',s.last_name) AS supervisor
FROM employees e
JOIN persons p ON p.person_id = e.person_id
LEFT JOIN employees sup ON sup.employee_id = e.supervisor_id
LEFT JOIN persons s   ON s.person_id = sup.person_id
ORDER BY e.employee_id;

-- Step 8: Count orders per customer with a LEFT JOIN (0 where none)
SELECT c.customer_id, p.first_name,
       COUNT(o.order_id) AS orders
FROM customers c
JOIN persons p ON p.person_id = c.person_id
LEFT JOIN orders o ON o.customer_id = c.customer_id
GROUP BY c.customer_id, p.first_name
ORDER BY c.customer_id;

-- Step 9: A warning about forgetting the ON clause (cartesian product)
SELECT COUNT(*)
FROM orders JOIN customers;

-- Step 10: INSERT ... SELECT into a self-contained practice table, then DROP it
DROP TABLE IF EXISTS practice_top_products;
CREATE TABLE practice_top_products (
  product_id INT PRIMARY KEY,
  name       VARCHAR(80) NOT NULL,
  total_qty  INT NOT NULL
);
INSERT INTO practice_top_products (product_id, name, total_qty)
SELECT p.product_id, p.name, SUM(oi.quantity)
FROM products p JOIN order_items oi ON oi.product_id = p.product_id
GROUP BY p.product_id, p.name
HAVING SUM(oi.quantity) >= 3
ORDER BY p.product_id;
SELECT * FROM practice_top_products ORDER BY product_id;
DROP TABLE practice_top_products;