-- run-as: root
-- Module 15 — Users, Privileges & Security · Exercise Solutions
-- Run: python3 dbctl.py sql --file modules/15-users-privileges-security/solutions/01-exercises.sql

-- Task 1 — create a least-privilege account
DROP USER IF EXISTS 'report_reader'@'%';
CREATE USER 'report_reader'@'%' IDENTIFIED BY 'ReadOnly_2024';
GRANT SELECT ON shopdb.* TO 'report_reader'@'%';
SHOW GRANTS FOR 'report_reader'@'%';

-- Task 2 — a reusable read-only role, granted to the account
DROP ROLE IF EXISTS 'read_only';
CREATE ROLE 'read_only';
GRANT SELECT ON shopdb.* TO 'read_only';
GRANT 'read_only' TO 'report_reader'@'%';
SET DEFAULT ROLE 'read_only' TO 'report_reader'@'%';
SHOW GRANTS FOR 'report_reader'@'%';

-- Task 3 — add write access, then revoke it
GRANT INSERT ON shopdb.* TO 'read_only';
SHOW GRANTS FOR 'read_only';
REVOKE INSERT ON shopdb.* FROM 'read_only';
SHOW GRANTS FOR 'read_only';

-- Task 4 — a prepared statement binds values as data
PREPARE price_query FROM
  'SELECT product_id, name, unit_price FROM products WHERE unit_price < ? ORDER BY unit_price';
SET @max_price = 5.00;
EXECUTE price_query USING @max_price;
DEALLOCATE PREPARE price_query;

-- Clean up (net-neutral) and confirm.
REVOKE 'read_only' FROM 'report_reader'@'%';
DROP USER IF EXISTS 'report_reader'@'%';
DROP ROLE IF EXISTS 'read_only';

SELECT
  (SELECT COUNT(*) FROM mysql.user WHERE user IN ('report_reader', 'read_only')) AS leftovers,
  (SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = 'shopdb') AS shopdb_tables;
