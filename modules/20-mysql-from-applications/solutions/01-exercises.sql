-- 20 · MySQL from Applications — Exercise Solutions
-- Run: python3 dbctl.py sql --file modules/20-mysql-from-applications/solutions/01-exercises.sql
-- Task 4 is the Python app:  python3 modules/20-mysql-from-applications/app/query_shop.py

-- Task 1 — the connection's identity and the idle timeout an app must survive.
SELECT
  CONNECTION_ID() AS connection_id,
  USER()          AS authenticated_as,
  CURRENT_USER()  AS effective_user,
  DATABASE()      AS current_db;

SELECT
  @@wait_timeout    AS idle_timeout_s,
  @@max_connections AS max_connections;

-- Task 2 — a server-side prepared statement, reused with two different parameters.
PREPARE by_category FROM 'SELECT product_id, name, unit_price FROM products WHERE category_id = ? ORDER BY product_id';

SET @category_id = 3;

EXECUTE by_category USING @category_id;

SET @category_id = 4;

EXECUTE by_category USING @category_id;

DEALLOCATE PREPARE by_category;

-- Task 3 — every client connection the server can see right now.
SELECT
  id,
  user,
  host,
  db,
  command,
  time
FROM information_schema.processlist
ORDER BY id;

-- Confirm shopdb is unchanged: still 10 tables.
SELECT COUNT(*) AS shopdb_tables
FROM information_schema.tables
WHERE table_schema = 'shopdb';
