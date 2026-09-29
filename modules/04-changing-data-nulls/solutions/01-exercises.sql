-- Solutions — Module 04 exercises (UPDATE / DELETE / NULL).
-- Run: make sql FILE=modules/04-changing-data-nulls/solutions/01-exercises.sql
-- Net-neutral: creates practice_menu_items and drops it, so shopdb stays at 10 tables.

-- Task 1 — Create the table and insert one row (explicit column list)
DROP TABLE IF EXISTS practice_menu_items;
CREATE TABLE practice_menu_items (
  item_id   INT PRIMARY KEY,
  name      VARCHAR(40) NOT NULL,
  price     DECIMAL(6,2) NOT NULL,
  is_vegan  BOOLEAN NOT NULL DEFAULT FALSE,
  note      VARCHAR(60) NULL
);
INSERT INTO practice_menu_items (item_id, name, price, is_vegan, note)
VALUES (1, 'Espresso', 2.50, FALSE, 'classic');
SELECT COUNT(*) AS n FROM practice_menu_items;

-- Task 2 — Insert multiple rows in one statement
INSERT INTO practice_menu_items (item_id, name, price, is_vegan, note)
VALUES
  (2, 'Cappuccino', 3.75, TRUE , NULL),
  (3, 'Matcha Latte', 4.25, TRUE , NULL);
SELECT COUNT(*) AS n FROM practice_menu_items;

-- Task 3 — Change data safely with a conditional UPDATE
UPDATE practice_menu_items SET price = price + 0.50 WHERE item_id = 2;
SELECT price FROM practice_menu_items WHERE item_id = 2;

-- Task 4 — NULL vs = NULL (the most common mistake)
UPDATE practice_menu_items SET note = 'chef pick' WHERE note IS NULL;
SELECT COUNT(*) AS n FROM practice_menu_items WHERE note IS NOT NULL;
UPDATE practice_menu_items SET note = 'never' WHERE note = NULL;
SELECT COUNT(*) AS n FROM practice_menu_items WHERE note = 'never';
DROP TABLE IF EXISTS practice_menu_items;
SELECT COUNT(*) AS tables_in_shopdb FROM information_schema.tables WHERE table_schema = 'shopdb';
