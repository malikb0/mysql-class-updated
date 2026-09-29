-- Module 10 — Data Modeling & Normalization · Exercise solutions.
-- Run:  python3 dbctl.py sql --file modules/10-data-modeling-normalization/solutions/01-exercises.sql
-- Each task is runnable and net-neutral (the practice_* tables are dropped again at the end).

-- Task 1 — Read the model: every foreign key in shopdb.
SELECT
  table_name,
  constraint_name,
  referenced_table_name
FROM information_schema.key_column_usage
WHERE table_schema = 'shopdb'
  AND referenced_table_name IS NOT NULL
ORDER BY table_name, constraint_name;

-- Task 2 — 1NF: turn the flat menu into one ingredient per row.
DROP TABLE IF EXISTS practice_menu_ingredient;

DROP TABLE IF EXISTS practice_menu_flat;

CREATE TABLE practice_menu_flat (
  dish         VARCHAR(80),
  ingredient_1 VARCHAR(80),
  ingredient_2 VARCHAR(80),
  ingredient_3 VARCHAR(80)
);

INSERT INTO practice_menu_flat VALUES
  ('Flat White',   'Espresso', 'Milk', NULL),
  ('Matcha Latte', 'Matcha',   'Milk', 'Honey');

CREATE TABLE practice_menu_ingredient (
  dish       VARCHAR(80),
  ingredient VARCHAR(80)
);

INSERT INTO practice_menu_ingredient (dish, ingredient)
SELECT dish, ingredient_1 FROM practice_menu_flat WHERE ingredient_1 IS NOT NULL
UNION ALL
SELECT dish, ingredient_2 FROM practice_menu_flat WHERE ingredient_2 IS NOT NULL
UNION ALL
SELECT dish, ingredient_3 FROM practice_menu_flat WHERE ingredient_3 IS NOT NULL;

SELECT COUNT(*) AS one_nf_rows
FROM practice_menu_ingredient;

-- Task 3 — 2NF/3NF: split product, order and line, then join them back.
DROP TABLE IF EXISTS practice_line;

DROP TABLE IF EXISTS practice_order;

DROP TABLE IF EXISTS practice_sku;

CREATE TABLE practice_sku (
  sku_id INT PRIMARY KEY,
  name   VARCHAR(80) NOT NULL
);

CREATE TABLE practice_order (
  order_id      INT PRIMARY KEY,
  customer_name VARCHAR(80) NOT NULL
);

CREATE TABLE practice_line (
  order_id INT NOT NULL,
  sku_id   INT NOT NULL,
  qty      INT NOT NULL,
  CONSTRAINT fk_practice_line_order FOREIGN KEY (order_id) REFERENCES practice_order (order_id),
  CONSTRAINT fk_practice_line_sku   FOREIGN KEY (sku_id)   REFERENCES practice_sku (sku_id)
);

INSERT INTO practice_sku VALUES
  (1, 'Espresso Blend'),
  (2, 'Croissant');

INSERT INTO practice_order VALUES
  (1, 'Aisha Khan'),
  (2, 'Bilal Ahmed');

INSERT INTO practice_line VALUES
  (1, 1, 2),
  (1, 2, 1),
  (2, 1, 1);

SELECT
  l.order_id,
  s.name AS product,
  l.qty
FROM practice_line AS l
JOIN practice_sku AS s ON s.sku_id = l.sku_id
ORDER BY l.order_id, s.name;

-- Task 4 — Analyse shopdb: each order's line count and total quantity.
SELECT
  order_id,
  COUNT(*)      AS line_count,
  SUM(quantity) AS total_units
FROM order_items
GROUP BY order_id
ORDER BY order_id;

-- Clean up: drop every practice table (net-neutral).
DROP TABLE IF EXISTS practice_line;

DROP TABLE IF EXISTS practice_order;

DROP TABLE IF EXISTS practice_sku;

DROP TABLE IF EXISTS practice_menu_ingredient;

DROP TABLE IF EXISTS practice_menu_flat;

SELECT COUNT(*) AS shopdb_tables
FROM information_schema.tables
WHERE table_schema = 'shopdb';
