-- run-as: root
-- 18 · Server Administration & Operations — worked example (net-neutral).
-- A few steps change server-wide runtime settings, so this file runs against the
-- admin account (the first line above tells dbctl.py to use root).
-- Run: python3 dbctl.py sql --file modules/18-server-administration-and-operations/examples/01-server-administration-and-operations.sql

-- Step 1 — the server's identity and where it keeps its data.
SELECT
  VERSION()                AS server_version,
  @@version_comment        AS build_comment,
  @@default_storage_engine AS default_engine,
  @@datadir                AS data_dir,
  @@port                   AS port;

-- Step 2 — the storage engines this build ships, and which of them do transactions.
SELECT
  engine,
  support,
  transactions
FROM information_schema.engines
ORDER BY engine;

-- Step 3 — the operational settings in effect (the config file, then the defaults).
SELECT
  @@innodb_buffer_pool_size AS buffer_pool_bytes,
  @@max_connections         AS max_connections,
  @@long_query_time         AS slow_threshold_s,
  @@slow_query_log          AS slow_log_on;

-- Step 4 — who is connected to the server right now.
SELECT
  id,
  user,
  host,
  db,
  command,
  time,
  state
FROM information_schema.processlist
ORDER BY id;

-- Step 5 — a few live counters the server keeps for you (values move constantly).
SELECT
  variable_name,
  variable_value
FROM performance_schema.global_status
WHERE variable_name IN ('Uptime', 'Threads_connected', 'Queries', 'Slow_queries')
ORDER BY variable_name;

-- Step 6 — turn the slow log on and lower the threshold so even a quick query counts.
SET GLOBAL slow_query_log = ON;

SET GLOBAL long_query_time = 0;

-- Step 7 — run a query. Surely it is "slow" now?
SELECT
  COUNT(*) AS paid_orders
FROM orders
WHERE status = 'paid';

-- Step 8 — read the counter back. Still 0! SET GLOBAL does not change the value a
--          session already copied when it connected — this session is still at 10.
SHOW GLOBAL STATUS LIKE 'Slow_queries';

-- Step 9 — fix it for this session too.
SET SESSION long_query_time = 0;

-- Step 10 — run the same query again; this one really is recorded.
SELECT
  COUNT(*) AS paid_orders
FROM orders
WHERE status = 'paid';

-- Step 11 — now the counter has moved.
SHOW GLOBAL STATUS LIKE 'Slow_queries';

-- Step 12 — put the slow-log settings back exactly as we found them.
SET SESSION long_query_time = 10;

SET GLOBAL slow_query_log = OFF;

SET GLOBAL long_query_time = 10;

-- Step 13 — refresh the optimizer's statistics for the busiest tables (safe and quick).
ANALYZE TABLE orders, order_items, products, payments;

-- Step 14 — check that a table's data and indexes are not corrupted.
CHECK TABLE orders, products;

-- Step 15 — OPTIMIZE rebuilds a table and its indexes: it defragments and reclaims space.
OPTIMIZE TABLE orders;

-- Step 16 — the size of every shopdb table: rows, data bytes and index bytes.
--           TABLE_ROWS is an estimate from the optimizer's statistics, not a COUNT(*).
SELECT
  table_name,
  engine,
  table_rows,
  data_length,
  index_length
FROM information_schema.tables
WHERE table_schema = 'shopdb'
ORDER BY (data_length + index_length) DESC;

-- Step 17 — confirm shopdb is unchanged: still 10 tables.
SELECT COUNT(*) AS shopdb_tables
FROM information_schema.tables
WHERE table_schema = 'shopdb';
