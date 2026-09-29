-- Task 1 — Create the table and insert one row
DROP TABLE IF EXISTS practice_menu_items;

CREATE TABLE practice_menu_items (
  item_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(80) NOT NULL,
  sku VARCHAR(20) NOT NULL UNIQUE,
  price DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  available BOOLEAN NOT NULL DEFAULT TRUE
);

INSERT INTO practice_menu_items (name, sku, price) VALUES ('Flat White','COF-004',13.00);

-- Task 2 — Batch insert with multi-row INSERT
INSERT INTO practice_menu_items (name, sku, price) VALUES
  ('Cappuccino','COF-006',7.50),
  ('Iced Latte','DRK-010',9.00),
  ('Matcha Tea','TEA-025',8.50);

-- Task 3 — Let DEFAULTs do the work
INSERT INTO practice_menu_items (name, sku) VALUES ('Cortado','COF-005');

SELECT name, price, available FROM practice_menu_items WHERE sku = 'COF-005';

-- Task 4 — Idempotent re-run
TRUNCATE TABLE practice_menu_items;

INSERT INTO practice_menu_items (name, sku, price) VALUES
  ('Flat White','COF-004',13.00),
  ('Cappuccino','COF-006',7.50);

DROP TABLE IF EXISTS practice_menu_items;

SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = 'shopdb';