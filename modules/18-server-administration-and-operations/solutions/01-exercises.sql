-- run-as: root
-- Module 18 — Server Administration & Operations · Exercise Solutions
-- Run: python3 dbctl.py sql --file modules/18-server-administration-and-operations/solutions/01-exercises.sql

-- Task 1 — read the server-wide operational settings.
SELECT
  @@innodb_buffer_pool_size AS buffer_pool_bytes,
  @@max_connections         AS max_connections,
  @@long_query_time         AS slow_threshold_s;

-- Task 2 — list the sessions connected right now.
SELECT
  id,
  user,
  host,
  db,
  command
FROM information_schema.processlist
ORDER BY id;

-- Task 3 — prove the slow log records a query, and meet the session gotcha.
SET GLOBAL slow_query_log = ON;

SET GLOBAL long_query_time = 0;

SELECT
  COUNT(*) AS paid_orders
FROM orders
WHERE status = 'paid';

-- Still 0: this session copied the old threshold when it connected.
SHOW GLOBAL STATUS LIKE 'Slow_queries';

SET SESSION long_query_time = 0;

SELECT
  COUNT(*) AS paid_orders
FROM orders
WHERE status = 'paid';

-- Now the counter has moved.
SHOW GLOBAL STATUS LIKE 'Slow_queries';

-- Restore the settings.
SET SESSION long_query_time = 10;

SET GLOBAL slow_query_log = OFF;

SET GLOBAL long_query_time = 10;

-- Task 4 — table maintenance on a real table: refresh statistics, then check integrity.
ANALYZE TABLE products;

CHECK TABLE products;

-- Confirm shopdb is still 10 tables.
SELECT COUNT(*) AS shopdb_tables
FROM information_schema.tables
WHERE table_schema = 'shopdb';
