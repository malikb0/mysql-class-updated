-- run-as: root
-- Module 19 — Replication & High Availability · Exercise Solutions
-- Run: python3 dbctl.py sql --file modules/19-replication-and-high-availability/solutions/01-exercises.sql

-- Task 1 — this server's replication posture.
SELECT
  @@server_id     AS server_id,
  @@log_bin       AS binlog_on,
  @@binlog_format AS binlog_format,
  @@gtid_mode     AS gtid_mode,
  @@sync_binlog   AS sync_binlog;

-- Task 2 — the current binary-log file and position a replica would copy from.
SHOW BINARY LOG STATUS;

-- Task 3 — this server is neither a replica nor (yet) a source of any replica.
SHOW REPLICA STATUS;

SHOW REPLICAS;

-- Task 4 — create the account a replica needs, then check its grants.
CREATE USER IF NOT EXISTS 'replica'@'%' IDENTIFIED WITH caching_sha2_password BY 'replica';

GRANT REPLICATION SLAVE, REPLICATION CLIENT ON *.* TO 'replica'@'%';

SHOW GRANTS FOR 'replica'@'%';

-- Clean up: drop the practice account and confirm shopdb is still 10 tables.
DROP USER IF EXISTS 'replica'@'%';

SELECT COUNT(*) AS shopdb_tables
FROM information_schema.tables
WHERE table_schema = 'shopdb';
