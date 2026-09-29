-- practice_products — a hands-on table to demonstrate core MySQL DDL concepts.
-- Run:  mysql -u root -p shopdb < 01-create-a-table.sql

DROP TABLE IF EXISTS practice_products;

CREATE TABLE practice_products (
  id            INT AUTO_INCREMENT PRIMARY KEY,
  sku           VARCHAR(20) NOT NULL UNIQUE,
  name          VARCHAR(80) NOT NULL,
  price         DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  in_stock      BOOLEAN NOT NULL DEFAULT FALSE,
  created_at    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
); -- step 2: create the table with AUTO_INCREMENT PK, VARCHAR, DECIMAL, BOOLEAN, TIMESTAMP + defaults, and constraints

DESCRIBE practice_products;
-- step 3: inspect column definitions

SHOW CREATE TABLE practice_products;
-- step 4: see full DDL including ENGINE=InnoDB

ALTER TABLE practice_products ADD COLUMN discontinued TINYINT(1) NOT NULL DEFAULT FALSE AFTER in_stock;
-- step 5: add a new column with a default value

ALTER TABLE practice_products MODIFY COLUMN price DECIMAL(8,2) NOT NULL DEFAULT 0.00;
-- step 6: modify an existing column (change type and default)

ALTER TABLE practice_products RENAME COLUMN discontinued TO is_discontinued;
-- step 7: rename a column

DESCRIBE practice_products;
-- step 8: verify the schema changes are reflected

DROP TABLE IF EXISTS practice_products;
-- step 9: clean up — remove the practice table

SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = 'shopdb';
-- step 10: confirm shopdb still has exactly 10 tables (net-neutral)
