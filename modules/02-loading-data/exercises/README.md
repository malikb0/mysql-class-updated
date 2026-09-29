# Module 02 — Loading Data (L1) · Exercises

Each task: **goal → hint → verify**. Solutions live in `../solutions/` (try first!).

## Task 1 — Create the table and insert one row
**Goal:** Create a new `practice_menu_items` table with exactly these five columns: `item_id INT AUTO_INCREMENT PRIMARY KEY`, `name VARCHAR(80) NOT NULL`, `sku VARCHAR(20) NOT NULL UNIQUE`, `price DECIMAL(10,2) NOT NULL DEFAULT 0.00`, and `available BOOLEAN NOT NULL DEFAULT TRUE`. Then insert a single row using an explicit column list.
**Hint:** Use `CREATE TABLE ... (column_def, ...)`. Remember to include the primary key definition. For the INSERT, always list the columns before the values so you can omit optional ones later.
**Verify:** The table exists and has exactly 5 columns:
```sql
SELECT COUNT(*) FROM information_schema.columns WHERE table_name = 'practice_menu_items';   -- expect 5
```

## Task 2 — Batch insert with multi-row INSERT
**Goal:** Add three more rows to `practice_menu_items` in a single statement using the multi-row `INSERT` syntax.
**Hint:** The second form of `INSERT` packs multiple value lists after one column list: `INSERT INTO tbl (a, b) VALUES (1, 2), (3, 4);`. Each pair goes on its own line for readability.
**Verify:** You now have four rows in the table:
```sql
SELECT COUNT(*) FROM practice_menu_items;   -- expect 4
```

## Task 3 — Let DEFAULTs do the work
**Goal:** Insert a row that deliberately omits `price` and `available`. Then show that MySQL supplied the defaults you defined.
**Hint:** Use an explicit column list with only `name` and `sku` in the INSERT, then SELECT those columns plus price and available to prove the defaults were applied.
**Verify:** The row shows `0.00` for price and `1` (TRUE) for available:
```sql
SELECT name, price, available FROM practice_menu_items WHERE sku = 'COF-004';   -- expect 0.00 | 1
```

## Task 4 — Idempotent re-run
**Goal:** Make the entire script safe to execute twice with no error and have it end by dropping `practice_menu_items`. This is the pattern every seed script uses: truncate (or drop), recreate, insert, verify, clean up.
**Hint:** Use `TRUNCATE TABLE practice_menu_items;` before re-inserting so you don't get duplicate primary keys or unique constraint violations. Then `DROP TABLE IF EXISTS practice_menu_items;`. Finally confirm shopdb still has exactly 10 tables (net-neutral).
**Verify:** The script can be run twice without error, and the final table count is back to 10:
```sql
SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = 'shopdb';   -- expect 10
```

Try each challenge on your own terminal before looking at `../solutions/01-exercises.sql`.