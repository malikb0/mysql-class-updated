-- Module 13 — Transactions & Concurrency · Exercise Solutions
-- Run: python3 dbctl.py sql --file modules/13-transactions-and-concurrency/solutions/01-exercises.sql

-- Task 1 — read the session's transaction defaults
SELECT
  @@autocommit            AS autocommit,
  @@transaction_isolation AS isolation_level;

-- Task 2 — COMMIT keeps a row
DROP TABLE IF EXISTS practice_tx_ex;

CREATE TABLE practice_tx_ex (
  id    INT AUTO_INCREMENT PRIMARY KEY,
  label VARCHAR(40) NOT NULL
) ENGINE = InnoDB;

START TRANSACTION;
INSERT INTO practice_tx_ex (label) VALUES ('committed');
COMMIT;
SELECT COUNT(*) AS after_commit FROM practice_tx_ex;

-- Task 3 — ROLLBACK discards a row (the committed row stays)
START TRANSACTION;
INSERT INTO practice_tx_ex (label) VALUES ('rolled back');
ROLLBACK;
SELECT COUNT(*) AS after_rollback FROM practice_tx_ex;

-- Task 4 — SAVEPOINT keeps part of a transaction
START TRANSACTION;
INSERT INTO practice_tx_ex (label) VALUES ('kept');
SAVEPOINT sp1;
INSERT INTO practice_tx_ex (label) VALUES ('discarded');
ROLLBACK TO SAVEPOINT sp1;
COMMIT;
SELECT id, label
FROM practice_tx_ex
ORDER BY id;

DROP TABLE IF EXISTS practice_tx_ex;

SELECT COUNT(*) AS shopdb_tables
FROM information_schema.tables
WHERE table_schema = 'shopdb';
