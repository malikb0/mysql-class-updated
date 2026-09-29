-- 20 · MySQL from Applications — worked example (net-neutral).
-- Run: python3 dbctl.py sql --file modules/20-mysql-from-applications/examples/01-mysql-from-applications.sql

-- Step 1 — the connection an application holds: who it is and what it is talking to.
SELECT
  CONNECTION_ID()      AS connection_id,
  USER()               AS authenticated_as,
  CURRENT_USER()       AS effective_user,
  DATABASE()           AS current_db,
  @@version            AS server_version;

-- Step 2 — the server-side limits an application's connection pool must respect.
SELECT
  @@wait_timeout       AS idle_timeout_s,
  @@max_connections    AS max_connections,
  @@thread_cache_size  AS thread_cache;

-- Step 3 — server-side prepared statements: the server binds the parameters, not your string.
PREPARE find_products FROM 'SELECT product_id, name, unit_price FROM products WHERE category_id = ? ORDER BY product_id';

SET @category_id = 1;

EXECUTE find_products USING @category_id;

-- Step 4 — reuse the SAME prepared statement with another value: bound, not re-parsed.
SET @category_id = 2;

EXECUTE find_products USING @category_id;

-- Step 5 — release the prepared statement when the application is done with it.
DEALLOCATE PREPARE find_products;

-- Step 6 — an application table to write to (dropped again at the end).
DROP TABLE IF EXISTS practice_app_demo;

CREATE TABLE practice_app_demo (
  demo_id  INT AUTO_INCREMENT PRIMARY KEY,
  label    VARCHAR(40) NOT NULL,
  qty      INT NOT NULL
) ENGINE = InnoDB;

-- Step 7 — an app-style parameterized insert: the values are bound, never concatenated.
INSERT INTO practice_app_demo (label, qty)
VALUES ('bound parameter', 3);

SELECT * FROM practice_app_demo ORDER BY demo_id;

-- Step 8 — clean up and confirm shopdb is back to 10 tables.
DROP TABLE practice_app_demo;

SELECT COUNT(*) AS shopdb_tables
FROM information_schema.tables
WHERE table_schema = 'shopdb';
