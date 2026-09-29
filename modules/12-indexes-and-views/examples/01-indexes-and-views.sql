-- 12 · Indexes & Views — worked example (net-neutral).
-- Run: python3 dbctl.py sql --file modules/12-indexes-and-views/examples/01-indexes-and-views.sql

-- Step 1 — what indexes already exist on the two hottest tables?
--          one row per indexed column (a composite index has several rows).
SELECT
  table_name,
  index_name,
  non_unique,
  seq_in_index,
  column_name
FROM information_schema.statistics
WHERE table_schema = 'shopdb'
  AND table_name IN ('orders', 'products')
ORDER BY table_name, index_name, seq_in_index;

-- Step 2 — a filter with NO usable index: orders.status is unindexed,
--          so the optimizer must scan the whole table (type = ALL).
EXPLAIN SELECT *
FROM orders
WHERE status = 'paid';

-- Step 3 — the same shape of query that DOES use a UNIQUE index:
--          products.sku is unique, so the lookup is a single constant row.
EXPLAIN SELECT *
FROM products
WHERE sku = 'COF-002';

-- Step 4 — a foreign-key column is indexed automatically:
--          orders.customer_id uses the fk_order_customer index (type = ref).
EXPLAIN SELECT *
FROM orders
WHERE customer_id = 3;

-- Step 5 — add the missing index, refresh statistics, and re-check the plan.
CREATE INDEX idx_practice_orders_status ON orders (status);

ANALYZE TABLE orders;

EXPLAIN SELECT *
FROM orders
WHERE status = 'paid';

-- Step 6 — read the new index back from the catalog, with its cardinality
--          (cardinality ≈ the number of distinct values the optimizer can see).
SELECT
  index_name,
  non_unique,
  column_name,
  cardinality
FROM information_schema.statistics
WHERE table_schema = 'shopdb'
  AND table_name = 'orders'
  AND index_name = 'idx_practice_orders_status';

-- Step 7 — drop the practice index now that we have seen it (net-neutral).
DROP INDEX idx_practice_orders_status ON orders;

-- Step 8 — a composite (covering) index: every column the query needs is in
--          the index, so MySQL answers it from the index alone (Extra = Using index).
--          We build it on a throwaway table because a composite index on an
--          existing FK column cannot be dropped while the foreign key uses it.
DROP TABLE IF EXISTS practice_index_demo;

CREATE TABLE practice_index_demo (
  demo_id     INT AUTO_INCREMENT PRIMARY KEY,
  customer_id INT NOT NULL,
  status      VARCHAR(20) NOT NULL,
  note        VARCHAR(40)
) ENGINE = InnoDB;

INSERT INTO practice_index_demo (customer_id, status, note) VALUES
  (1, 'paid',    'a'),
  (1, 'shipped', 'b'),
  (2, 'paid',    'c'),
  (2, 'paid',    'd'),
  (3, 'pending', 'e');

CREATE INDEX idx_practice_demo_cover ON practice_index_demo (customer_id, status);

EXPLAIN SELECT customer_id, status
FROM practice_index_demo
WHERE customer_id = 1;

-- Step 9 — clean up the practice table (net-neutral).
DROP TABLE practice_index_demo;

-- Step 10 — a view is a saved SELECT with a name you can query like a table.
CREATE OR REPLACE VIEW v_practice_product_catalog AS
SELECT
  p.product_id,
  p.name      AS product,
  c.name      AS category,
  p.unit_price
FROM products AS p
JOIN categories AS c ON c.category_id = p.category_id;

SELECT *
FROM v_practice_product_catalog
ORDER BY product_id;

-- Step 11 — the view's definition lives in the catalog (information_schema.views).
SELECT
  table_name,
  is_updatable,
  check_option
FROM information_schema.views
WHERE table_schema = 'shopdb'
  AND table_name = 'v_practice_product_catalog';

-- Step 12 — CREATE OR REPLACE VIEW swaps the definition without dropping dependents.
CREATE OR REPLACE VIEW v_practice_product_catalog AS
SELECT
  product_id,
  name AS product,
  unit_price,
  is_active
FROM products;

SELECT *
FROM v_practice_product_catalog
ORDER BY product_id;

-- Step 13 — clean up the view, and confirm shopdb is back to 10 tables.
DROP VIEW IF EXISTS v_practice_product_catalog;

SELECT COUNT(*) AS shopdb_tables
FROM information_schema.tables
WHERE table_schema = 'shopdb';
