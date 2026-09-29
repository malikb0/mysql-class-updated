-- 13 · Transactions & Concurrency — worked example (net-neutral).
-- Run: python3 dbctl.py sql --file modules/13-transactions-and-concurrency/examples/01-transactions-and-concurrency.sql

-- Step 1 — the session defaults: autocommit is on, isolation is REPEATABLE READ.
SELECT
  @@autocommit            AS autocommit,
  @@transaction_isolation AS isolation_level;

-- Step 2 — a throwaway table on InnoDB, the engine that supports transactions.
DROP TABLE IF EXISTS practice_tx;

CREATE TABLE practice_tx (
  id    INT AUTO_INCREMENT PRIMARY KEY,
  label VARCHAR(40) NOT NULL
) ENGINE = InnoDB;

-- Step 3 — a transaction that COMMITs: the row becomes durable.
START TRANSACTION;
INSERT INTO practice_tx (label) VALUES ('committed');
COMMIT;
SELECT COUNT(*) AS after_commit FROM practice_tx;

-- Step 4 — a transaction that ROLLBACKs: the row disappears.
START TRANSACTION;
INSERT INTO practice_tx (label) VALUES ('rolled back');
SELECT COUNT(*) AS inside_transaction FROM practice_tx;
ROLLBACK;
SELECT COUNT(*) AS after_rollback FROM practice_tx;

-- Step 5 — SAVEPOINT: undo part of a transaction, keep the rest.
START TRANSACTION;
INSERT INTO practice_tx (label) VALUES ('kept');
SAVEPOINT sp1;
INSERT INTO practice_tx (label) VALUES ('discarded');
ROLLBACK TO SAVEPOINT sp1;
COMMIT;
SELECT id, label
FROM practice_tx
ORDER BY id;

-- Step 6 — change the isolation level for THIS session, then set it back.
SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;
SELECT @@transaction_isolation AS isolation_level;
SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- Step 7 — row locking: SELECT … FOR UPDATE holds a lock until the transaction ends.
START TRANSACTION;
SELECT id, label
FROM practice_tx
WHERE id = 1
FOR UPDATE;
COMMIT;
SELECT COUNT(*) AS rows_after_lock FROM practice_tx;

-- Step 8 — clean up (net-neutral) and confirm the schema is unchanged.
DROP TABLE IF EXISTS practice_tx;

SELECT COUNT(*) AS shopdb_tables
FROM information_schema.tables
WHERE table_schema = 'shopdb';
