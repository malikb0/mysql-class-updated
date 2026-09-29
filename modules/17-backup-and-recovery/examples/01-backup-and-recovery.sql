-- run-as: root
-- 17 · Backup & Recovery — worked example (net-neutral).
-- Reading binary-log state needs the REPLICATION CLIENT privilege, so this file runs
-- against the admin account (the first line above tells dbctl.py to use root).
-- Run: python3 dbctl.py sql --file modules/17-backup-and-recovery/examples/01-backup-and-recovery.sql

-- Step 1 — the server's backup posture in one row: is the binary log on, what does
--          it record, where does it live, and can we write files for dumps?
SELECT
  @@log_bin        AS binlog_on,
  @@binlog_format  AS binlog_format,
  @@server_id      AS server_id,
  @@gtid_mode      AS gtid_mode,
  @@datadir        AS data_dir,
  @@secure_file_priv AS secure_file_priv;

-- Step 2 — the current binary-log file and position: the exact point a new backup
--          would start replaying from in a point-in-time recovery.
--          (MySQL 8.4 renamed SHOW MASTER STATUS → SHOW BINARY LOG STATUS.)
SHOW BINARY LOG STATUS;

-- Step 3 — every binary-log file the server is holding, with its size.
SHOW BINARY LOGS;

-- Step 4 — what a logical backup actually stores: the exact CREATE statement plus
--          a COPY of the rows. Here it is for one real table.
SHOW CREATE TABLE payments;

-- Step 5 — a restore drill you can run entirely in SQL. First a tiny "live" table.
DROP TABLE IF EXISTS practice_backup_demo;

CREATE TABLE practice_backup_demo (
  demo_id INT AUTO_INCREMENT PRIMARY KEY,
  item    VARCHAR(30) NOT NULL,
  qty     INT NOT NULL
) ENGINE = InnoDB;

INSERT INTO practice_backup_demo (item, qty) VALUES
  ('Espresso Blend', 3),
  ('House Roast',    2),
  ('Croissant',      5);

SELECT * FROM practice_backup_demo ORDER BY demo_id;

-- Step 6 — take a point-in-time copy (a logical snapshot of the rows).
DROP TABLE IF EXISTS practice_backup_demo_snap;

CREATE TABLE practice_backup_demo_snap AS
SELECT *
FROM practice_backup_demo;

-- Step 7 — now "damage" the live table: delete a row and corrupt another.
DELETE FROM practice_backup_demo
WHERE item = 'House Roast';

UPDATE practice_backup_demo
SET qty = 999
WHERE item = 'Croissant';

SELECT * FROM practice_backup_demo ORDER BY demo_id;

-- Step 8 — restore the rows from the snapshot: empty the live table, then copy the
--          snapshot back. The table ends exactly as it was at Step 6.
DELETE FROM practice_backup_demo;

INSERT INTO practice_backup_demo (demo_id, item, qty)
SELECT demo_id, item, qty
FROM practice_backup_demo_snap;

SELECT * FROM practice_backup_demo ORDER BY demo_id;

-- Step 9 — clean up both practice tables and confirm shopdb is back to 10 tables.
DROP TABLE practice_backup_demo_snap;

DROP TABLE practice_backup_demo;

SELECT COUNT(*) AS shopdb_tables
FROM information_schema.tables
WHERE table_schema = 'shopdb';
