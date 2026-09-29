-- practice_products_load — the three ways to insert rows into a table.
-- Run it with:  python3 dbctl.py sql --file modules/02-loading-data/examples/01-insert-and-load.sql

-- Step 1 — create the table (AUTO_INCREMENT PK, VARCHAR, DECIMAL, BOOLEAN; constraints + defaults)
DROP TABLE IF EXISTS practice_products_load;

CREATE TABLE practice_products_load (
  product_id INT AUTO_INCREMENT PRIMARY KEY,
  name       VARCHAR(80) NOT NULL,
  sku        VARCHAR(20) NOT NULL UNIQUE,
  unit_price DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  in_stock   BOOLEAN NOT NULL DEFAULT TRUE
);

-- Step 2 — single-row INSERT (explicit column list)
INSERT INTO practice_products_load (name, sku, unit_price) VALUES ('Espresso Blend','COF-001',12.50);

-- Step 3 — multi-row INSERT
INSERT INTO practice_products_load (name, sku, unit_price) VALUES
  ('House Roast','COF-002',10.00),
  ('Green Tea','TEA-001',8.00);

-- Step 4 — INSERT omitting unit_price and in_stock to show the DEFAULTs at work
INSERT INTO practice_products_load (name, sku) VALUES ('Decaf','COF-003');

-- Step 5 — verify the four rows, with defaults applied
SELECT * FROM practice_products_load;

-- Step 6 — safe to re-run: drop the table, then confirm shopdb is back to 10 tables
DROP TABLE IF EXISTS practice_products_load;

SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = 'shopdb';
