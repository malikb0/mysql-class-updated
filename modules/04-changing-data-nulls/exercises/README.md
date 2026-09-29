# Changing Data — UPDATE, DELETE & NULLs

This module teaches how to modify existing rows safely and why `NULL` is not a value you can compare with `=`. The `shopdb` café database has exactly 10 tables; all practice work uses the temporary table below, so dropping it at the end leaves the schema untouched.

## Practice Table

```sql
CREATE TABLE practice_menu_items (
    item_id INT PRIMARY KEY,
    name VARCHAR(40) NOT NULL,
    price DECIMAL(6,2) NOT NULL,
    is_vegan BOOLEAN NOT NULL DEFAULT FALSE,
    note VARCHAR(60) NULL
);
```

## Task 1 — Create the table and insert one row (explicit column list)

**Goal:** Write `CREATE TABLE` for `practice_menu_items`, then insert this row using an explicit column list:
`(1, 'Espresso', 2.50, FALSE, 'classic')`.

**Hint:** Use `(column_name, ...) VALUES (...)`. Never rely on positional matching — it breaks as soon as you add a column.

**Verify:** After running your statements, run:
```sql
SELECT COUNT(*) AS n FROM practice_menu_items;
```
Expected output:

| n |
|---|
| 1 |

## Task 2 — Insert multiple rows in one statement

**Goal:** Add two more items in a single multi-row `INSERT`, leaving `note` as NULL for both:
`(2, 'Cappuccino', 3.75, TRUE, NULL)` and `(3, 'Matcha Latte', 4.25, TRUE, NULL)`.

**Hint:** Multiple value lists go after the single `VALUES` keyword, separated by commas. Explicitly write `NULL` — do not use an empty string.

**Verify:**
```sql
SELECT COUNT(*) AS n FROM practice_menu_items;
```
Expected output:

| n |
|---|
| 3 |

## Task 3 — Change data safely with a conditional UPDATE

**Goal:** Increase the price of item 2 (`Cappuccino`) by exactly $0.50 using a `WHERE` clause that matches on `item_id`, then confirm the new value.

**Hint:** Always include a `WHERE` clause in an `UPDATE`; without it, every row is modified. Arithmetic in `SET` is evaluated per row before writing.

**Verify:**
```sql
SELECT price FROM practice_menu_items WHERE item_id = 2;
```
Expected output:

| price |
|---|
| 4.25 |

## Task 4 — NULL vs `= NULL` (the most common mistake)

**Goal:** First, assign a note to every row whose `note` is currently NULL using `IS NULL`. Then try the same assignment with `WHERE note = NULL` and explain why it affects zero rows. Finally, drop the practice table so the schema returns to its original 10 tables.

**Hint:**
- `NULL IS NULL` evaluates to TRUE; `NULL = NULL` evaluates to UNKNOWN (three-valued logic treats "unknown" as distinct from any value).
- After dropping the table, confirm `shopdb` has exactly 10 tables via `information_schema.tables`.

**Verify — step 1 (only the two NULL rows change, so all three rows now have a note):**
```sql
UPDATE practice_menu_items SET note = 'chef pick' WHERE note IS NULL;
SELECT COUNT(*) AS n FROM practice_menu_items WHERE note IS NOT NULL;
```
Expected output:

| n |
|---|
| 3 |

**Verify — step 2 (`= NULL` never matches):**
```sql
UPDATE practice_menu_items SET note = 'never' WHERE note = NULL;
SELECT COUNT(*) AS n FROM practice_menu_items WHERE note = 'never';
```
Expected output:

| n |
|---|
| 0 |

**Verify — step 3 (cleanup):**
```sql
DROP TABLE IF EXISTS practice_menu_items;
SELECT COUNT(*) AS n FROM information_schema.tables WHERE table_schema = 'shopdb';
```
Expected output:

| n |
|---|
| 10 |

---

Try each task on your own before looking at the solutions. Compare your approach with `../solutions/01-exercises.sql` and discuss why it works (or doesn't).
