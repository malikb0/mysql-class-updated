-- Module 07: Subqueries, CTEs & Window Functions
-- Examples for the shopdb database.
-- Run with:
--   python dbctl.py sql --file modules/07-subqueries-ctes-window-functions/examples/01-subqueries-ctes-window.sql

-- Part A — Subqueries

-- 1. Scalar subquery — products above the average price
SELECT name, unit_price FROM products
WHERE unit_price > (SELECT AVG(unit_price) FROM products)
ORDER BY unit_price DESC;   -- 5 rows

-- 2. IN subquery — customers who bought a Merch product (category_id = 4)
SELECT DISTINCT c.customer_id, p.first_name
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id
JOIN persons p   ON p.person_id = c.person_id
WHERE o.order_id IN (
  SELECT oi.order_id FROM order_items oi
  WHERE oi.product_id IN (SELECT product_id FROM products WHERE category_id = 4)
)
ORDER BY c.customer_id;   -- 3 rows (customers 2,4,6)

-- 3. EXISTS — customers who have a shipped order
SELECT c.customer_id, p.first_name
FROM customers c JOIN persons p ON p.person_id = c.person_id
WHERE EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.customer_id AND o.status = 'shipped')
ORDER BY c.customer_id;   -- 2 rows (customers 1,2)

-- 4. NOT EXISTS — customers with no cancelled order
SELECT c.customer_id, p.first_name
FROM customers c JOIN persons p ON p.person_id = c.person_id
WHERE NOT EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.customer_id AND o.status = 'cancelled')
ORDER BY c.customer_id;   -- 5 rows (customers 1,2,3,4,6)

-- 5. Correlated subquery — how many times each product was ordered
SELECT p.product_id, p.name,
       (SELECT COUNT(*) FROM order_items oi WHERE oi.product_id = p.product_id) AS times_ordered
FROM products p ORDER BY p.product_id;   -- 10 rows

-- 6. ANY — products pricier than any Merch item
SELECT name, unit_price FROM products
WHERE unit_price > ANY (SELECT unit_price FROM products WHERE category_id = 4)
ORDER BY unit_price;   -- 1 row (Tote Bag 18.00)

-- Part B — Common Table Expressions (CTEs)

-- 7. CTE for order totals, then total spent per customer
WITH order_totals AS (
  SELECT o.order_id, o.customer_id, SUM(oi.quantity * oi.unit_price) AS total
  FROM orders o JOIN order_items oi ON oi.order_id = o.order_id
  GROUP BY o.order_id, o.customer_id
)
SELECT c.customer_id, p.first_name, SUM(ot.total) AS spent
FROM order_totals ot
JOIN customers c ON c.customer_id = ot.customer_id
JOIN persons p   ON p.person_id = c.person_id
GROUP BY c.customer_id, p.first_name
ORDER BY c.customer_id;   -- 6 rows (1:46.50, 2:44.00, 3:24.00, 4:26.50, 5:9.00, 6:34.00)

-- 8. Same CTE, filtered with HAVING (customers spending over 25)
WITH order_totals AS (
  SELECT o.order_id, o.customer_id, SUM(oi.quantity * oi.unit_price) AS total
  FROM orders o JOIN order_items oi ON oi.order_id = o.order_id
  GROUP BY o.order_id, o.customer_id
)
SELECT c.customer_id, p.first_name, SUM(ot.total) AS spent
FROM order_totals ot
JOIN customers c ON c.customer_id = ot.customer_id
JOIN persons p   ON p.person_id = c.person_id
GROUP BY c.customer_id, p.first_name
HAVING SUM(ot.total) > 25
ORDER BY c.customer_id;   -- 4 rows (1,2,4,6)

-- 9. Recursive CTE — the employee hierarchy from the top
WITH RECURSIVE org AS (
  SELECT employee_id, person_id, supervisor_id, role, 1 AS depth
  FROM employees WHERE supervisor_id IS NULL
  UNION ALL
  SELECT e.employee_id, e.person_id, e.supervisor_id, e.role, org.depth + 1
  FROM employees e JOIN org ON e.supervisor_id = org.employee_id
)
SELECT org.employee_id, p.first_name, org.role, org.depth
FROM org JOIN persons p ON p.person_id = org.person_id
ORDER BY org.employee_id;   -- 5 rows (employee 1 depth 1; 2,3,4 depth 2; 5 depth 3)

-- Part C — Window functions

-- 10. ROW_NUMBER — price rank within each category
SELECT category_id, name, unit_price,
       ROW_NUMBER() OVER (PARTITION BY category_id ORDER BY unit_price DESC) AS rn
FROM products ORDER BY category_id, rn;   -- 10 rows

-- 11. RANK vs DENSE_RANK on order totals (there is a tie at 24.00)
WITH order_totals AS (
  SELECT o.order_id, SUM(oi.quantity * oi.unit_price) AS total
  FROM orders o JOIN order_items oi ON oi.order_id = o.order_id
  GROUP BY o.order_id
)
SELECT order_id, total,
       RANK()       OVER (ORDER BY total DESC) AS rnk,
       DENSE_RANK() OVER (ORDER BY total DESC) AS drnk
FROM order_totals ORDER BY total DESC;   -- 8 rows; RANK jumps 4,4,6 while DENSE_RANK gives 4,4,5

-- 12. Running total with a window SUM
WITH order_totals AS (
  SELECT o.order_id, SUM(oi.quantity * oi.unit_price) AS total
  FROM orders o JOIN order_items oi ON oi.order_id = o.order_id
  GROUP BY o.order_id
)
SELECT order_id, total,
       SUM(total) OVER (ORDER BY order_id) AS running_total
FROM order_totals ORDER BY order_id;   -- 8 rows (last running_total 184.00)

-- 13. LAG — the previous order's total
WITH order_totals AS (
  SELECT o.order_id, SUM(oi.quantity * oi.unit_price) AS total
  FROM orders o JOIN order_items oi ON oi.order_id = o.order_id
  GROUP BY o.order_id
)
SELECT order_id, total, LAG(total) OVER (ORDER BY order_id) AS previous_total
FROM order_totals ORDER BY order_id;   -- first row previous_total is NULL