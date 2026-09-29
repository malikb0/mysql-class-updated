-- run-as: root
-- Module 17 — Backup & Recovery · Exercise Solutions
-- Run: python3 dbctl.py sql --file modules/17-backup-and-recovery/solutions/01-exercises.sql

-- Task 1 — confirm the binary log is on, its format, and the current writable
--          log file and position (the recovery starting point).
SELECT
  @@log_bin       AS binlog_on,
  @@binlog_format AS binlog_format,
  @@server_id     AS server_id;

SHOW BINARY LOG STATUS;

-- Task 2 — list every binary-log file the server keeps.
SHOW BINARY LOGS;

-- Task 3 — a full logical backup/restore drill of one table, in SQL.
DROP TABLE IF EXISTS practice_restore_demo;

CREATE TABLE practice_restore_demo (
  demo_id INT AUTO_INCREMENT PRIMARY KEY,
  item    VARCHAR(30) NOT NULL,
  qty     INT NOT NULL
) ENGINE = InnoDB;

INSERT INTO practice_restore_demo (item, qty) VALUES
  ('Green Tea', 4),
  ('Earl Grey', 6),
  ('Chai',      1);

-- The "backup" — a point-in-time copy of the rows.
DROP TABLE IF EXISTS practice_restore_snap;

CREATE TABLE practice_restore_snap AS
SELECT *
FROM practice_restore_demo;

-- Simulate data loss, then restore from the snapshot and verify the row count.
DELETE FROM practice_restore_demo;

INSERT INTO practice_restore_demo (demo_id, item, qty)
SELECT demo_id, item, qty
FROM practice_restore_snap;

SELECT COUNT(*) AS restored_rows
FROM practice_restore_demo;

-- Task 4 — what a dump stores for a table (the CREATE statement it replays).
SHOW CREATE TABLE products;

-- Clean up and confirm shopdb is back to 10 tables.
DROP TABLE practice_restore_snap;

DROP TABLE practice_restore_demo;

SELECT COUNT(*) AS shopdb_tables
FROM information_schema.tables
WHERE table_schema = 'shopdb';
