-- 10 · Data Modeling & Normalization — worked example (net-neutral).
-- Run:  python3 dbctl.py sql --file modules/10-data-modeling-normalization/examples/01-modeling-and-normalization.sql

-- Step 1 — read the model that already exists: the tables in shopdb.
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'shopdb'
ORDER BY table_name;

-- Step 2 — read the relationships the model already encodes (foreign keys).
SELECT
  table_name,
  constraint_name,
  referenced_table_name
FROM information_schema.key_column_usage
WHERE table_schema = 'shopdb'
  AND referenced_table_name IS NOT NULL
ORDER BY table_name, constraint_name;

-- Step 3 — start from an UNNORMALIZED flat table: one row per order, with the
--          products repeating across numbered columns.
DROP TABLE IF EXISTS practice_order_flat;

CREATE TABLE practice_order_flat (
  order_id      INT,
  customer_name VARCHAR(80),
  product_1     VARCHAR(80),
  product_2     VARCHAR(80),
  product_3     VARCHAR(80)
);

INSERT INTO practice_order_flat VALUES
  (1, 'Aisha Khan', 'Espresso Blend', 'Croissant', NULL),
  (2, 'Aisha Khan', 'Green Tea',      'Muffin',    'Ceramic Mug');

SELECT * FROM practice_order_flat ORDER BY order_id;

-- Step 4 — 1NF: one value per cell, no repeating groups -> one row per line item.
DROP TABLE IF EXISTS practice_order_line;

CREATE TABLE practice_order_line (
  order_id INT,
  product  VARCHAR(80),
  quantity INT
);

INSERT INTO practice_order_line VALUES
  (1, 'Espresso Blend', 1),
  (1, 'Croissant',      1),
  (2, 'Green Tea',      1),
  (2, 'Muffin',         1),
  (2, 'Ceramic Mug',    1);

SELECT * FROM practice_order_line ORDER BY order_id, product;

-- Step 5 — 2NF: the customer belongs to the order, not to each line item.
--          Split the header (order -> customer) from the lines (step 4).
DROP TABLE IF EXISTS practice_order_header;

CREATE TABLE practice_order_header (
  order_id      INT PRIMARY KEY,
  customer_name VARCHAR(80) NOT NULL
);

INSERT INTO practice_order_header VALUES
  (1, 'Aisha Khan'),
  (2, 'Aisha Khan');

SELECT * FROM practice_order_header ORDER BY order_id;

-- Step 6 — 3NF: the customer name should not be repeated on every order
--          (a transitive dependency). Give customers their own table.
DROP TABLE IF EXISTS practice_order;

DROP TABLE IF EXISTS practice_customer;

CREATE TABLE practice_customer (
  customer_id INT PRIMARY KEY,
  name        VARCHAR(80) NOT NULL
);

CREATE TABLE practice_order (
  order_id    INT PRIMARY KEY,
  customer_id INT NOT NULL,
  CONSTRAINT fk_practice_order_customer
    FOREIGN KEY (customer_id) REFERENCES practice_customer (customer_id)
);

INSERT INTO practice_customer VALUES
  (1, 'Aisha Khan'),
  (2, 'Bilal Ahmed');

INSERT INTO practice_order VALUES
  (1, 1),
  (2, 1);

-- Step 7 — join the 3NF model back together to rebuild the original picture.
SELECT
  o.order_id,
  c.name AS customer
FROM practice_order AS o
JOIN practice_customer AS c ON c.customer_id = o.customer_id
ORDER BY o.order_id;

-- Step 8 — clean up: drop every practice table so shopdb stays net-neutral.
DROP TABLE IF EXISTS practice_order;
DROP TABLE IF EXISTS practice_customer;
DROP TABLE IF EXISTS practice_order_header;
DROP TABLE IF EXISTS practice_order_line;
DROP TABLE IF EXISTS practice_order_flat;

-- Step 9 — confirm shopdb is back to exactly 10 tables.
SELECT COUNT(*) AS shopdb_tables
FROM information_schema.tables
WHERE table_schema = 'shopdb';
