-- 11 · Keys, Constraints & Relationships — worked example (net-neutral).
-- Run:  python3 dbctl.py sql --file modules/11-keys-constraints-relationships/examples/01-keys-and-constraints.sql

-- Step 1 — the primary keys the seed model already declares.
SELECT
  table_name,
  constraint_name
FROM information_schema.table_constraints
WHERE table_schema = 'shopdb'
  AND constraint_type = 'PRIMARY KEY'
ORDER BY table_name;

-- Step 2 — build a tiny parent/child pair that exercises every key kind:
--          PK (auto-increment), UNIQUE, NOT NULL, DEFAULT, CHECK, and a FK.
DROP TABLE IF EXISTS practice_book;

DROP TABLE IF EXISTS practice_author;

CREATE TABLE practice_author (
  author_id INT AUTO_INCREMENT PRIMARY KEY,
  name      VARCHAR(80) NOT NULL UNIQUE
);

CREATE TABLE practice_book (
  book_id   INT AUTO_INCREMENT PRIMARY KEY,
  author_id INT NOT NULL,
  title     VARCHAR(120) NOT NULL,
  isbn      CHAR(13) NOT NULL UNIQUE,
  price     DECIMAL(6,2) NOT NULL DEFAULT 0.00,
  in_print  TINYINT(1) NOT NULL DEFAULT 1,
  CONSTRAINT chk_practice_book_price CHECK (price >= 0),
  CONSTRAINT fk_practice_book_author
    FOREIGN KEY (author_id) REFERENCES practice_author (author_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- Step 3 — insert valid rows (every constraint passes).
INSERT INTO practice_author (name) VALUES
  ('Naomi Okafor'),
  ('Ravi Menon');

INSERT INTO practice_book (author_id, title, isbn, price) VALUES
  (1, 'The Normal Form',  '9780000000001', 24.99),
  (1, 'Keys and Indexes', '9780000000002', 19.50),
  (2, 'Transactions',     '9780000000003', 31.00);

SELECT
  b.book_id,
  b.title,
  a.name AS author,
  b.price,
  b.in_print
FROM practice_book AS b
JOIN practice_author AS a ON a.author_id = b.author_id
ORDER BY b.book_id;

-- Step 4 — read the constraints the database is now enforcing.
SELECT
  table_name,
  constraint_name,
  constraint_type
FROM information_schema.table_constraints
WHERE table_schema = 'shopdb'
  AND table_name IN ('practice_author', 'practice_book')
ORDER BY table_name, constraint_type, constraint_name;

-- Step 5 — which columns back each key.
SELECT
  table_name,
  constraint_name,
  column_name
FROM information_schema.key_column_usage
WHERE table_schema = 'shopdb'
  AND table_name IN ('practice_author', 'practice_book')
ORDER BY table_name, constraint_name, ordinal_position;

-- Step 6 — the referential actions recorded for the foreign key.
SELECT
  constraint_name,
  delete_rule,
  update_rule
FROM information_schema.referential_constraints
WHERE constraint_schema = 'shopdb'
  AND constraint_name = 'fk_practice_book_author';

-- Step 7 — ON DELETE CASCADE in action: remove an author and the books follow.
DELETE FROM practice_author
WHERE author_id = 2;

SELECT COUNT(*) AS books_after_cascade
FROM practice_book;

-- Step 8 — clean up: drop the practice tables (net-neutral).
DROP TABLE IF EXISTS practice_book;

DROP TABLE IF EXISTS practice_author;

-- Step 9 — confirm shopdb is back to exactly 10 tables.
SELECT COUNT(*) AS shopdb_tables
FROM information_schema.tables
WHERE table_schema = 'shopdb';
