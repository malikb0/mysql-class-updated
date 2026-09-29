# Module 16 — Performance & Query Tuning · Exercises

Each task: **goal → hint → verify**. Solutions live in `../solutions/` (try first!).

## Task 1 — Inventory the indexes on `order_items`

### Goal
Every table you've seen so far has one index, usually a primary key. But some tables need more than one to keep queries fast. **Inventory every index on `order_items`, including non-unique ones.** The query below reads from `information_schema.statistics`. Run it and inspect the output — that is your answer.

> 🎯 Goal: list every index and its columns on `order_items`
```sql
SELECT
  index_name,
  non_unique,
  column_name
FROM information_schema.statistics
WHERE table_schema = 'shopdb'
  AND table_name = 'order_items'
ORDER BY index_name, seq_in_index;
```

### Hint
Think of the data in this table: each row links an order to a product and a quantity. The query engine needs two things to find rows — first "which orders contain item X?" and second "what is item Y's price?". Each lookup direction benefits from its own index. Write down what you see before moving on.

### Verify
Three indexes: `PRIMARY` (order_item_id, unique), `fk_item_order` (order_id), and `fk_item_product` (product_id), each with `seq_in_index = 1`. This is exactly the structure a beginner would expect to discover.

---

## Task 2 — Read the plan for a lookup by category

### Goal
You're trying to find all products in a particular category. Write a SELECT that filters on `category_id` and run it with EXPLAIN to see how MySQL will actually execute it. Then read the plan's `type` and `key` columns carefully.

> 🎯 Goal: understand why a simple WHERE clause can still be fast
```sql
EXPLAIN SELECT product_id, name, unit_price
FROM products
WHERE category_id = 1;
```

### Hint
Look at the `Extra` column in the EXPLAIN output — does MySQL need to touch any table rows at all? The plan should reveal whether this query is already using an index. If it isn't, you're about to learn why that doesn't happen here (hint: look back at the schema).

### Verify
The EXPLAIN output shows `type = ref`, `key = fk_product_category`, and `rows = 3`. This means MySQL used a single-row lookup on an index — fast, even without reading any table rows.

---

## Task 3 — Add an index to a practice table and watch the plan change

### Goal
Build a new table with 500 rows, explain a query against it (expect a full scan), then add an index and explain again (expect a lookup). The table is called `practice_tune_demo` and has three columns: `demo_id`, `region`, and `amount`. Write the CREATE TABLE statement yourself.

> 🎯 Goal: prove that MySQL's query plan changes when you change its indexes
```sql
CREATE TABLE practice_tune_demo (
  demo_id INT PRIMARY KEY,
  region VARCHAR(50),
  amount DECIMAL(10,2) NOT NULL
);

-- Insert 500 rows here — use a loop or a SELECT from any table
INSERT INTO practice_tune_demo VALUES ...;

EXPLAIN SELECT demo_id, amount
FROM practice_tune_demo
WHERE region = 'north';
```

### Hint
Before you add the index, what does EXPLAIN say about this query? Then write `CREATE INDEX idx_practice_tune_region ON practice_tune_demo (region);` and explain again. Notice the difference in the plan — that's exactly what an index is supposed to do.

### Verify
**Before the index:** `type = ALL`, `rows = 500`. **After the index:** `type = ref`, `key = idx_practice_tune_region`, `rows = 100` (assuming roughly equal distribution). The full scan became a single-index lookup.

---

## Task 4 — Prove a covering index

### Goal
Covering indexes are fast because MySQL reads from the index itself and skips table lookups. Add an index on `(region, amount)` to `practice_tune_demo`, then explain a SELECT that asks for only those two columns with a WHERE clause on region. The plan should prove you're reading from the index alone.

> 🎯 Goal: show that MySQL can answer your query without touching the table at all
```sql
EXPLAIN SELECT region, amount
FROM practice_tune_demo
WHERE region = 'north';
```

### Hint
First create the index yourself (`CREATE INDEX idx_practice_tune_cover ON practice_tune_demo (region, amount);`), then explain the query. The `Extra` column should say "Using index" — that is your proof that no table rows were read at all. This is what real-world performance tuning looks like in practice.

### Verify
The EXPLAIN output shows `key = idx_practice_tune_cover` and `Extra = Using index`. MySQL found the answer entirely from the index — zero table I/O for a covering query on 500 rows.

---

> 🧪 Try it yourself first — then peek at the solutions in `../solutions/` to see how they're done.

**Remember:** each task should leave your database net-neutral (drop anything you create before ending the script). This habit keeps your environment clean and makes every run repeatable.