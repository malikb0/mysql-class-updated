-- Module 16 — Performance & Query Tuning · Exercise Solutions
-- Run: python3 dbctl.py sql --file modules/16-performance-and-query-tuning/solutions/01-exercises.sql

-- Task 1 — every index on the order_items table, with its columns and uniqueness
SELECT
  index_name,
  non_unique,
  column_name
FROM information_schema.statistics
WHERE table_schema = 'shopdb'
  AND table_name = 'order_items'
ORDER BY index_name, seq_in_index;

-- Task 2 — the optimizer's plan for a products lookup by category.
--          category_id is a foreign key, so it is already indexed (ref).
EXPLAIN SELECT product_id, name, unit_price
FROM products
WHERE category_id = 1;

-- Task 3 — a realistic table, then the before/after of adding one index.
SET SESSION cte_max_recursion_depth = 2000;

DROP TABLE IF EXISTS practice_tune_demo;

CREATE TABLE practice_tune_demo (
  demo_id  INT AUTO_INCREMENT PRIMARY KEY,
  region   VARCHAR(20) NOT NULL,
  amount   DECIMAL(10,2) NOT NULL
) ENGINE = InnoDB;

INSERT INTO practice_tune_demo (region, amount)
WITH RECURSIVE seq (n) AS (
  SELECT 1
  UNION ALL
  SELECT n + 1 FROM seq WHERE n < 500
)
SELECT
  ELT((n % 5) + 1, 'north', 'south', 'east', 'west', 'central'),
  (n % 100) + 1.00
FROM seq;

ANALYZE TABLE practice_tune_demo;

-- Task 3a — expect type = ALL: no index on region yet.
EXPLAIN SELECT demo_id, amount
FROM practice_tune_demo
WHERE region = 'north';

CREATE INDEX idx_practice_tune_region ON practice_tune_demo (region);

ANALYZE TABLE practice_tune_demo;

-- Task 3b — expect type = ref and key = idx_practice_tune_region.
EXPLAIN SELECT demo_id, amount
FROM practice_tune_demo
WHERE region = 'north';

-- Task 4 — a covering index answers the query from the index alone.
--          Selecting only the indexed columns gives Extra = Using index.
CREATE INDEX idx_practice_tune_cover ON practice_tune_demo (region, amount);

ANALYZE TABLE practice_tune_demo;

EXPLAIN SELECT region, amount
FROM practice_tune_demo
WHERE region = 'north';

-- Clean up so shopdb is exactly as seeded, then confirm 10 tables.
DROP TABLE practice_tune_demo;

SELECT COUNT(*) AS shopdb_tables
FROM information_schema.tables
WHERE table_schema = 'shopdb';
