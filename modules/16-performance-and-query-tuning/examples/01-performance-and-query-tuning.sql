-- 16 · Performance & Query Tuning — worked example (net-neutral).
-- Run: python3 dbctl.py sql --file modules/16-performance-and-query-tuning/examples/01-performance-and-query-tuning.sql

-- Step 1 — what indexes already exist on the two hottest tables?
--          Every row is one indexed column; a composite index has several rows.
SELECT
  table_name,
  index_name,
  non_unique,
  seq_in_index,
  column_name,
  cardinality
FROM information_schema.statistics
WHERE table_schema = 'shopdb'
  AND table_name IN ('orders', 'products')
ORDER BY table_name, index_name, seq_in_index;

-- Step 2 — baseline: a filter on orders.status, which has NO index.
--          type = ALL means MySQL reads every row in the table.
EXPLAIN SELECT order_id, customer_id
FROM orders
WHERE status = 'paid';

-- Step 3 — a lookup on the UNIQUE column products.sku: one constant row (const).
EXPLAIN SELECT product_id, name, unit_price
FROM products
WHERE sku = 'COF-002';

-- Step 4 — a lookup on a foreign-key column: the FK index narrows it (ref).
EXPLAIN SELECT order_id, order_date
FROM orders
WHERE customer_id = 3;

-- Step 5 — add the missing index, refresh statistics, and re-read the plan.
CREATE INDEX idx_practice_orders_status ON orders (status);

ANALYZE TABLE orders;

EXPLAIN SELECT order_id, customer_id
FROM orders
WHERE status = 'paid';

-- Step 6 — read the new index back with its cardinality
--          (cardinality ≈ distinct values the optimizer knows about).
SELECT
  index_name,
  non_unique,
  column_name,
  cardinality
FROM information_schema.statistics
WHERE table_schema = 'shopdb'
  AND table_name = 'orders'
  AND index_name = 'idx_practice_orders_status';

-- Step 7 — drop the practice index so shopdb is exactly as seeded (net-neutral).
DROP INDEX idx_practice_orders_status ON orders;

-- Step 8 — the 8-row tables are too small to show real tuning trade-offs, so
--          build a practice table with 5,000 rows. A recursive CTE generates the
--          rows; cte_max_recursion_depth must be raised above the default (1000).
SET SESSION cte_max_recursion_depth = 20000;

DROP TABLE IF EXISTS practice_perf_demo;

CREATE TABLE practice_perf_demo (
  demo_id     INT AUTO_INCREMENT PRIMARY KEY,
  customer_id INT NOT NULL,
  status      VARCHAR(20) NOT NULL,
  created_at  DATE NOT NULL,
  note        VARCHAR(40)
) ENGINE = InnoDB;

INSERT INTO practice_perf_demo (customer_id, status, created_at, note)
WITH RECURSIVE seq (n) AS (
  SELECT 1
  UNION ALL
  SELECT n + 1 FROM seq WHERE n < 5000
)
SELECT
  (n % 200) + 1,
  ELT((n % 4) + 1, 'pending', 'paid', 'shipped', 'cancelled'),
  DATE_ADD('2024-01-01', INTERVAL (n % 365) DAY),
  CONCAT('row ', n)
FROM seq;

ANALYZE TABLE practice_perf_demo;

-- Step 9 — the same status filter, now against 5,000 rows and still no index.
--          The optimizer estimates it must read all 5,000 rows.
EXPLAIN SELECT demo_id
FROM practice_perf_demo
WHERE status = 'paid';

-- Step 10 — index the status column and re-check: now it reads ~1,250 rows.
CREATE INDEX idx_practice_demo_status ON practice_perf_demo (status);

ANALYZE TABLE practice_perf_demo;

EXPLAIN SELECT demo_id
FROM practice_perf_demo
WHERE status = 'paid';

-- Step 11 — a higher-cardinality column is far more selective:
--           200 distinct customers vs 4 distinct statuses.
CREATE INDEX idx_practice_demo_customer ON practice_perf_demo (customer_id);

ANALYZE TABLE practice_perf_demo;

EXPLAIN SELECT demo_id, customer_id
FROM practice_perf_demo
WHERE customer_id = 42;

-- Step 12 — query smell: wrapping an indexed column in a function hides the index.
--           With no index on created_at, this is a full table scan.
EXPLAIN SELECT demo_id
FROM practice_perf_demo
WHERE YEAR(created_at) = 2024;

-- Step 13 — add the index, then compare a function filter with a range filter.
CREATE INDEX idx_practice_demo_date ON practice_perf_demo (created_at);

ANALYZE TABLE practice_perf_demo;

-- type = index: MySQL scans the whole index because YEAR(created_at) cannot be
-- used as a range — the function is applied to every row before comparing.
EXPLAIN SELECT demo_id
FROM practice_perf_demo
WHERE YEAR(created_at) = 2024;

-- type = range: the same intent written as a range uses the index to jump
-- straight to June 2024 (about 420 rows).
EXPLAIN SELECT demo_id
FROM practice_perf_demo
WHERE created_at >= '2024-06-01'
  AND created_at < '2024-07-01';

-- Step 14 — the N+1 shape: a correlated subquery is re-run once per outer row
--           (DEPENDENT SUBQUERY), while one join answers the whole question.
EXPLAIN SELECT
  o.order_id,
  (SELECT COUNT(*) FROM order_items AS oi WHERE oi.order_id = o.order_id) AS item_count
FROM orders AS o;

EXPLAIN SELECT
  o.order_id,
  COUNT(oi.order_item_id) AS item_count
FROM orders AS o
LEFT JOIN order_items AS oi ON oi.order_id = o.order_id
GROUP BY o.order_id;

-- Step 15 — clean up the practice objects and confirm shopdb is back to 10 tables.
DROP TABLE practice_perf_demo;

SELECT COUNT(*) AS shopdb_tables
FROM information_schema.tables
WHERE table_schema = 'shopdb';
