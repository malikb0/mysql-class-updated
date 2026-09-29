-- run-as: root
-- 19 · Replication & High Availability — worked example (net-neutral).
-- Reading replication and binary-log state needs the REPLICATION CLIENT privilege,
-- so this file runs against the admin account (the first line above tells dbctl.py to use root).
-- Run: python3 dbctl.py sql --file modules/19-replication-and-high-availability/examples/01-replication-and-high-availability.sql

-- Step 1 — this server's replication posture in one row.
SELECT
  @@server_id                AS server_id,
  @@log_bin                  AS binlog_on,
  @@binlog_format            AS binlog_format,
  @@gtid_mode                AS gtid_mode,
  @@enforce_gtid_consistency AS enforce_gtid_consistency,
  @@sync_binlog              AS sync_binlog,
  @@log_replica_updates      AS log_replica_updates;

-- Step 2 — how long binary logs are kept, then the current file and position:
--          the exact point a replica would start copying from.
SELECT
  @@binlog_expire_logs_seconds AS expire_seconds,
  @@server_id                  AS server_id;

SHOW BINARY LOG STATUS;

-- Step 3 — every binary-log file the server is holding.
SHOW BINARY LOGS;

-- Step 4 — is this server itself a replica of another server? (No: empty set.)
SHOW REPLICA STATUS;

-- Step 5 — does this server have any replicas connected to it? (None yet: empty set.)
SHOW REPLICAS;

-- Step 6 — a small table to watch through the replication drill.
DROP TABLE IF EXISTS practice_repl_demo;

CREATE TABLE practice_repl_demo (
  demo_id INT AUTO_INCREMENT PRIMARY KEY,
  note    VARCHAR(40) NOT NULL
) ENGINE = InnoDB;

INSERT INTO practice_repl_demo (note) VALUES
  ('orders opened'),
  ('first payment');

-- Step 7 — the rows a replica would receive once it is connected.
SELECT * FROM practice_repl_demo ORDER BY demo_id;

-- Step 8 — clean up and confirm shopdb is back to 10 tables.
DROP TABLE practice_repl_demo;

SELECT COUNT(*) AS shopdb_tables
FROM information_schema.tables
WHERE table_schema = 'shopdb';
