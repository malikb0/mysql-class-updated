-- Task 1 — build a constrained table
DROP TABLE IF EXISTS practice_orders;
DROP TABLE IF EXISTS practice_inventory;

-- step 1: create practice_inventory with the exact constraints and defaults
CREATE TABLE practice_inventory (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(80) NOT NULL,
  sku VARCHAR(20) NOT NULL UNIQUE,
  price DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  added_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- step 2: inspect the table schema
DESCRIBE practice_inventory;

-- step 3: view the full DDL (note ENGINE=InnoDB)
SHOW CREATE TABLE practice_inventory;

-- expect 5 columns
SELECT COUNT(*) FROM information_schema.columns WHERE table_name = 'practice_inventory';

-- Task 2 — add a new column (quantity)
ALTER TABLE practice_inventory ADD COLUMN quantity INT NOT NULL DEFAULT 0 AFTER price;

-- Task 3 — modify a column type and rename a column
ALTER TABLE practice_inventory
  MODIFY COLUMN name VARCHAR(100) NOT NULL,
  RENAME COLUMN sku TO product_code;

-- verify the schema changes are reflected
DESCRIBE practice_inventory;

-- view updated DDL with the new column, the modified name length, and the renamed column
SHOW CREATE TABLE practice_inventory;

-- Task 4 — create a table with a foreign key referencing practice_inventory
CREATE TABLE practice_orders (
  id INT AUTO_INCREMENT PRIMARY KEY,
  order_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  inventory_id INT NOT NULL,
  quantity_ordered INT NOT NULL DEFAULT 1,
  CONSTRAINT fk_inventory FOREIGN KEY (inventory_id) REFERENCES practice_inventory(id)
);

-- verify the FK constraint is properly defined
SHOW CREATE TABLE practice_orders;

-- cleanup: remove both practice tables
DROP TABLE IF EXISTS practice_orders;
DROP TABLE IF EXISTS practice_inventory;

-- expect 10 (net-neutral)
SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = 'shopdb';
