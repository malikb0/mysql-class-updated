# Module 12 — Indexes & Views · Exercises

Each task: **goal → hint → verify**. Solutions live in `../solutions/` (try first!).

---

## Task 1 — List every index on the `orders` table

**Goal:** Query `information_schema.statistics` to list all indexes that MySQL has built for the `orders` table. You'll see primary keys, foreign-key constraints, and any unique or composite indexes you've created.

**Hint:** Look at the columns `table_name`, `index_name`, and `column_name`. Filter on `table_name = 'orders'`.

**Verify:** 3 rows returned — one for the primary key (`pk_orders`), one for the foreign-key reference to customers, and one for the foreign-key reference to products.

---

## Task 2 — Explain a lookup by category

**Goal:** Run `EXPLAIN` on this query:
```sql
SELECT product_id, product_name, price
FROM products
WHERE category_id = 1;
```
Notice what MySQL can use (or cannot use) to find the matching rows. The goal is to confirm that the foreign-key index on `products.category_id` speeds up a simple equality lookup.

**Hint:** Compare the output with and without the foreign-key index (temporarily drop it, run EXPLAIN again, then recreate it). Without the index you should see a full table scan; with it you should see an indexed seek.

**Verify:** The `key` column shows `fk_product_category` and the `type` is `ref`. This means MySQL used the foreign-key index to find matching rows instead of scanning every row in the table.

---

## Task 3 — Build, count, and drop a view

**Goal:** Create a view that joins `products` to `categories`, filters on `is_active = 1`, and presents five columns: product ID, product name, price, category name, and category description. Then run `SELECT COUNT(*) FROM your_view_name;`. Finally, drop the view.

**Hint:** Write the view as a simple inner join with an ON clause matching `products.category_id = categories.category_id`. Views are virtual — they don't store data, so dropping one costs nothing.

**Verify:** The count returns 10 rows (the active products), and after you drop the view any further reference to it produces an error. This confirms views are just stored query definitions.

---

## Task 4 — Prove a covering index is used

**Goal:** Create a small InnoDB table with three columns, then create a composite index on two of them. Write an `EXPLAIN` for a SELECT that fetches only those two indexed columns (no third column). The goal is to prove that MySQL can read the values directly from the index without touching the clustered primary-key data.

**Hint:** A covering index means all the columns in your query are part of the index — so MySQL satisfies the query entirely by walking the index leaf pages, with no extra row lookbacks into the heap (`Using index`).

**Verify:** The `Extra` column shows `Using index`. That's MySQL telling you "I don't need to read any rows from the table; all values I want are already in this secondary index." This is the holy covering-index effect.

---

> 🧪 Try it yourself first — then peek at the solutions in `../solutions/` to see how they're done.

Each task should leave your database **net-neutral**: if you create an index, view, or table during a task, drop it at the end so the next run starts in the same clean state as the previous one.