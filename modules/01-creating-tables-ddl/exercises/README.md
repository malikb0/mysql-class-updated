# Module 01 — Creating Tables (DDL) · Exercises

Each task: **goal → hint → verify**. Solutions live in `../solutions/` (try first!).

## Task 1 — Build a constrained table
**Goal:** Create a new `practice_inventory` table with exactly these five columns: `id INT AUTO_INCREMENT PRIMARY KEY`, `name VARCHAR(80) NOT NULL`, `sku VARCHAR(20) NOT NULL UNIQUE`, `price DECIMAL(10,2) NOT NULL DEFAULT 0.00`, and `added_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP`.
**Hint:** Use `CREATE TABLE ... (column_def, ...)`. Remember to include the primary key definition.
**Verify:** The table exists and has exactly 5 columns:
```sql
SELECT COUNT(*) FROM information_schema.columns WHERE table_name = 'practice_inventory';   -- expect 5
```

## Task 2 — Inspect and extend the schema
**Goal:** Use `DESCRIBE` to inspect your `practice_inventory` table, then add a new column with `ALTER TABLE ... ADD COLUMN`.
**Hint:** Run `DESCRIBE practice_inventory;` first. Then use `ADD COLUMN <name> <type> [NOT NULL] [DEFAULT <value>] AFTER <column>` (or at end).
**Verify:** The new column appears in the description and the table now has 6 columns:
```sql
SELECT COUNT(*) FROM information_schema.columns WHERE table_name = 'practice_inventory';   -- expect 6
```

## Task 3 — Modify and rename
**Goal:** Use `ALTER TABLE ... MODIFY COLUMN` to change a column's data type, then use `RENAME COLUMN` to rename an existing column.
**Hint:** `MODIFY COLUMN <name> <new_type>` replaces the entire definition (use it carefully). For renaming: `RENAME COLUMN <old_name> TO <new_name>`.
**Verify:** `DESCRIBE practice_inventory;` shows the renamed column (with its new type) alongside the columns from Task 2.

## Task 4 — Foreign key and cleanup
**Goal:** Create a second `practice_orders` table with a `FOREIGN KEY` referencing `practice_inventory(id)`, then drop both practice tables.
**Hint:** Define the foreign key in the column definition or use `ALTER TABLE ... ADD CONSTRAINT`. After creating, verify with `SHOW CREATE TABLE practice_orders;`. Then drop both: `DROP TABLE IF EXISTS practice_orders; DROP TABLE IF EXISTS practice_inventory;`.
**Verify:** Both tables are gone and shopdb still has exactly 10 tables (net-neutral):
```sql
SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = 'shopdb';   -- expect 10
```
