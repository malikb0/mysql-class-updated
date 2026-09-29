# Module 17 — Backup & Recovery · Exercises

Each task: **goal → hint → verify**. Solutions live in `../solutions/` (try first!).

---

## Task 1 — Check the binary log is on

**Goal.** Confirm that your server's binary log is enabled and understand what kind of information it captures. This is the first step before any point-in-time recovery can happen.

```sql
SELECT
  @@log_bin       AS binlog_on,
  @@binlog_format AS binlog_format,
  @@server_id     AS server_id;
```

> ⚠️ Gotcha: `@@log_bin` is a one-offence flag — if it's off, point-in-time recovery is impossible.

**Hint.** Run the query above as the `root` admin user (the same account used to start MySQL). Then run `SHOW BINARY LOG STATUS;` and look at which file the server is currently writing to.

> 💡 Aha: the binary log records *every* change, so it's your complete replay replay key — but it grows without limit until you purge it.

**Verify.** `binlog_on = 1`, `binlog_format = ROW`, `server_id = 1`; `SHOW BINARY LOG STATUS` shows the current file and position (run as `root`). Drop any tables you create before finishing so the database stays net-neutral.

---

## Task 2 — List the binary logs

**Goal.** See exactly what files are on disk: every binary log the server is still holding. Understanding which logs exist tells you where to start a recovery window and how much space they consume.

```sql
SHOW BINARY LOGS;
```

> ⚠️ Gotcha: `mysqladmin --user=root purge-binaries older-than 2 days` — but only if a backup can cover the gap.

**Hint.** Run the query as root on your local server (the seed data includes three log files). Notice that each row has a file size and an `Encrypted` column. Compare these sizes against the dump you'll take in Task 3.

> 🧪 Try it: before reading further, run the command yourself and record what you see — that experience will make your notes authentic later on.

**Verify.** Three rows (`binlog.000001`, `binlog.000002`, `binlog.000003`), each with a file size and `Encrypted = No`. Drop anything you create before finishing so the database stays net-neutral.

---

## Task 3 — A backup and restore drill

**Goal.** Simulate a disaster: copy a small table, delete its rows, then restore from the copy. This exercise proves that your restoration strategy actually works on real data.

```sql
SELECT COUNT(*) AS restored_rows
FROM practice_restore_demo;
```

> 🎯 Goal: take a logical backup of `practice_restore_demo`, insert three demo rows, delete them all, run `mysqldump` (or copy the file), restore from the backup, and confirm three rows are back.

**Hint.** Create `practice_restore_demo` with two columns (`id INT PRIMARY KEY, name VARCHAR(40)`). Insert three rows, delete everything, then use either a logical dump or an InnoDB snapshot to bring them back. The restored count is your only validation metric.

> 🧪 Try it: before reading further, run the command yourself and record what you see — that experience will make your notes authentic later on.

**Verify.** `restored_rows = 3` after the restore. Drop anything you create before finishing so the database stays net-neutral.

---

## Task 4 — See what a dump stores

**Goal.** A logical backup is a `.sql` file — it contains DDL (`CREATE TABLE`) and data statements. Understanding its structure tells you whether you can edit it by hand, how much storage it takes, and what schema changes a restore would carry.

```sql
SHOW CREATE TABLE products;
```

> 🎯 Goal: dump the `products` table with `mysqldump --user=root --password=YOUR_PASSWORD shopdb products > /tmp/products.sql` then run `mysql -u root < /tmp/products.sql` on a fresh database, and examine the dumped statements.

**Hint.** Run `SHOW CREATE TABLE products;` as root to see its exact DDL. Then dump it (`mysqldump --user=root --password=YOUR_PASSWORD shopdb products > /tmp/products.sql`) and inspect the file with `cat /tmp/products.sql | head -20`. Notice that every column, constraint, and index is preserved.

> 🧪 Try it: before reading further, run the command yourself and record what you see — that experience will make your notes authentic later on.

**Verify.** The statement includes `PRIMARY KEY (\`product_id\`)`, `UNIQUE KEY \`sku\` (\`sku\`)`, and the `fk_product_category` foreign key. Drop anything you create before finishing so the database stays net-neutral.

---

> 🧪 Try it yourself first — then peek at the solutions in `../solutions/` to see how they're done.

**Closing note:** each of these four tasks should leave the database **net-neutral**. Any table or view you create must be dropped before your script finishes, so that running all four exercises leaves no trace on a clean installation.