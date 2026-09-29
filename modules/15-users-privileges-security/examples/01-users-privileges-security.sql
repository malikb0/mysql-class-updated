-- run-as: root
-- 15 · Users, Privileges & Security — worked example (net-neutral).
-- This file creates accounts and grants, which the non-SUPER app user cannot do, so it
-- runs against the admin account (the first line above tells dbctl.py to use root).
-- Run: python3 dbctl.py sql --file modules/15-users-privileges-security/examples/01-users-privileges-security.sql

-- Step 1 — start from a clean slate so the file is safe to run repeatedly.
DROP USER IF EXISTS 'report_reader'@'%';
DROP ROLE IF EXISTS 'read_only';

-- Step 2 — create a least-privilege account and a reusable role.
CREATE USER 'report_reader'@'%' IDENTIFIED BY 'ReadOnly_2024';
CREATE ROLE 'read_only';

-- Step 3 — give the role only what a reporting user needs: read access.
GRANT SELECT ON shopdb.* TO 'read_only';

-- Step 4 — hand the role to the account and make it the account's default role.
GRANT 'read_only' TO 'report_reader'@'%';
SET DEFAULT ROLE 'read_only' TO 'report_reader'@'%';

-- Step 5 — inspect exactly what the account can do.
SHOW GRANTS FOR 'report_reader'@'%';

-- Step 6 — add write access to the role, then take it away again.
GRANT INSERT ON shopdb.* TO 'read_only';
SHOW GRANTS FOR 'read_only';

REVOKE INSERT ON shopdb.* FROM 'read_only';
SHOW GRANTS FOR 'read_only';

-- Step 7 — prepared statements: bind a value as data instead of pasting it into SQL.
PREPARE price_query FROM
  'SELECT product_id, name, unit_price FROM products WHERE unit_price < ? ORDER BY unit_price';
SET @max_price = 5.00;
EXECUTE price_query USING @max_price;
DEALLOCATE PREPARE price_query;

-- Step 8 — even a malicious-looking value stays data when it is bound, so it cannot
-- change the query's meaning. Here the value is the literal text `' OR 1=1`, not SQL.
PREPARE name_query FROM 'SELECT COUNT(*) AS matches FROM products WHERE name = ?';
SET @evil = "' OR 1=1";
EXECUTE name_query USING @evil;
DEALLOCATE PREPARE name_query;

-- Step 9 — clean up the account and role (net-neutral), then confirm.
REVOKE 'read_only' FROM 'report_reader'@'%';
DROP USER IF EXISTS 'report_reader'@'%';
DROP ROLE IF EXISTS 'read_only';

SELECT
  (SELECT COUNT(*) FROM mysql.user WHERE user = 'report_reader')                       AS report_reader_accounts,
  (SELECT COUNT(*) FROM mysql.user WHERE user IN ('report_reader', 'read_only'))       AS leftovers,
  (SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = 'shopdb')       AS shopdb_tables;
