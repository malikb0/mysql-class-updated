-- practice_menu_items — demonstrates UPDATE/DELETE and how NULL behaves.
-- Run: make sql FILE=modules/04-changing-data-nulls/examples/01-update-delete-null.sql

-- Step 1 — create a throwaway practice table (net-neutral: dropped at the end).
DROP TABLE IF EXISTS practice_menu_items;
CREATE TABLE practice_menu_items (
  item_id   INT PRIMARY KEY,
  name      VARCHAR(40) NOT NULL,
  price     DECIMAL(6,2) NOT NULL,
  is_vegan  BOOLEAN NOT NULL DEFAULT FALSE,
  note      VARCHAR(60) NULL
);

-- Step 2 — insert four rows; two leave note as NULL (column omitted), two set a short note.
INSERT INTO practice_menu_items (item_id, name, price, is_vegan, note)
VALUES
  (1, 'Espresso',            2.50, FALSE, 'classic'),
  (2, 'Cappuccino',          3.75, TRUE , NULL),
  (3, 'Matcha Latte',        4.25, TRUE , NULL),
  (4, 'Chocolate Croissant', 3.00, FALSE, 'house special');

-- Step 3 — show the starting data.
SELECT * FROM practice_menu_items;

-- Step 4 — increase one price; confirm just that row changed.
UPDATE practice_menu_items SET price = price + 0.50 WHERE item_id = 2;
SELECT item_id, name, price FROM practice_menu_items WHERE item_id = 2;

-- Step 5 — fill the two NULL notes. IS NULL matches them; confirm 2 rows changed.
UPDATE practice_menu_items SET note = 'chef pick' WHERE note IS NULL;
SELECT ROW_COUNT() AS rows_changed;

-- Step 6 — this changes 0 rows: '= NULL' is never TRUE (NULL means "unknown", not "empty").
UPDATE practice_menu_items SET note = 'never' WHERE note = NULL;
SELECT ROW_COUNT() AS rows_changed;

-- Step 7 — arithmetic with NULL yields NULL; COALESCE gives a readable fallback.
SELECT name, price + NULL AS price_plus_unknown FROM practice_menu_items LIMIT 1;
SELECT name, COALESCE(note, '(none)') AS note_fixed FROM practice_menu_items;

-- Step 8 — delete just the vegan rows, then show what remains.
DELETE FROM practice_menu_items WHERE is_vegan = TRUE;
SELECT * FROM practice_menu_items;

-- Step 9 — WARNING: an UPDATE/DELETE with no WHERE hits EVERY row. Always filter:
--   UPDATE table SET col = val WHERE condition;

-- Step 10 — cleanup; shopdb still has exactly 10 tables (net-neutral).
DROP TABLE IF EXISTS practice_menu_items;
SELECT COUNT(*) AS tables_in_shopdb FROM information_schema.tables WHERE table_schema = 'shopdb';
