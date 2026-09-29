-- Module 12 — Indexes & Views · Exercise Solutions
-- Run: python3 dbctl.py sql --file modules/12-indexes-and-views/solutions/01-exercises.sql

-- Task 1 — every index on the orders table, with its columns and uniqueness
SELECT
  index_name,
  non_unique,
  column_name
FROM information_schema.statistics
WHERE table_schema = 'shopdb'
  AND table_name = 'orders'
ORDER BY index_name, seq_in_index;

-- Task 2 — the optimizer's plan for a products lookup by category
EXPLAIN SELECT *
FROM products
WHERE category_id = 1;

-- Task 3 — a view over the active products, then count its rows
CREATE OR REPLACE VIEW v_practice_active_catalog AS
SELECT
  p.product_id,
  p.name     AS product,
  c.name     AS category
FROM products AS p
JOIN categories AS c ON c.category_id = p.category_id
WHERE p.is_active = 1;

SELECT COUNT(*) AS active_products
FROM v_practice_active_catalog;

DROP VIEW IF EXISTS v_practice_active_catalog;

-- Task 4 — prove a covering index is used (Extra = Using index)
DROP TABLE IF EXISTS practice_cover_demo;

CREATE TABLE practice_cover_demo (
  demo_id     INT AUTO_INCREMENT PRIMARY KEY,
  customer_id INT NOT NULL,
  status      VARCHAR(20) NOT NULL
) ENGINE = InnoDB;

INSERT INTO practice_cover_demo (customer_id, status) VALUES
  (1, 'paid'),
  (1, 'shipped'),
  (2, 'paid');

CREATE INDEX idx_practice_cover ON practice_cover_demo (customer_id, status);

EXPLAIN SELECT customer_id, status
FROM practice_cover_demo
WHERE customer_id = 1;

DROP TABLE practice_cover_demo;

SELECT COUNT(*) AS shopdb_tables
FROM information_schema.tables
WHERE table_schema = 'shopdb';
