# Module 18 — Server Administration & Operations · Exercises

Each task: **goal → hint → verify**. Solutions live in `../solutions/` (try first!).

---

## Task 1 — Read the server's operational settings

**Goal:** show the buffer pool size, the connection limit and the slow-query threshold from Step 3.
```sql
SELECT
  @@innodb_buffer_pool_size AS buffer_pool_bytes,
  @@max_connections         AS max_connections,
  @@long_query_time         AS slow_threshold_s;
```

**Hint:** read server variables with `SELECT @@variable_name`; the values in Step 3 are `134217728`, `151` and `10.000000`.

> ⚠️ Gotcha: the buffer pool is set to bytes, not megabytes — use `/ 1024 / 1024` if you need MB.

**Verify:** `buffer_pool_bytes = 134217728` (128 MiB), `max_connections = 151`, `slow_threshold_s = 10.000000`.

---

## Task 2 — List the sessions connected right now

**Goal:** list every session so you can see who is connected and what they are doing, from Step 4.
```sql
SELECT
  id,
  user,
  host,
  db,
  command
FROM information_schema.processlist
ORDER BY id;
```

**Hint:** the `information_schema.processlist` view lists every thread and client connection on the server — including the system daemon that runs scheduled events.

> 💡 Aha: you will see at least one session for `root` with `db = shopdb`, alongside the `event_scheduler` daemon that MySQL starts automatically to run its internal scheduled tasks.

**Verify:** at least one session for `root` with `db = shopdb`, alongside the `event_scheduler` daemon.

---

## Task 3 — Prove the slow log records a query — and meet the session gotcha

**Goal:** turn the slow log on, set `long_query_time` to 0, run a query, read `Slow_queries` (still 0), then fix it with `SET SESSION`.
```sql
SHOW GLOBAL STATUS LIKE 'Slow_queries';
```

**Hint:** the behaviour in Steps 6–11 — `SET GLOBAL` does not change your session until you also `SET SESSION` — is called a "session gotcha." Try to reproduce it yourself.

> 🎯 Goal: start with `SET GLOBAL slow_query_log = ON; SET GLOBAL long_query_time = 0;`, then run any query, then read the counter (it will be 0), then do Step 9 (`SET SESSION long_query_time = 0;`) and try again — you should see it move.

**Verify:** the first read is `Slow_queries = 0`; after `SET SESSION long_query_time = 0` and another query it is greater than 0; at the end `slow_query_log = 0` and `long_query_time = 10` again.

---

## Task 4 — Run routine maintenance on a table

**Goal:** refresh statistics for, then verify the integrity of, the `products` table (Steps 13–14).
```sql
ANALYZE TABLE products;
```

**Hint:** `ANALYZE TABLE` tells the optimizer how many rows and index entries there are — run it after any data change. `CHECK TABLE` verifies a table's data and indexes, and should always return `OK`.

> 🧪 Try it: first do `ANALYZE TABLE products;`, then `CHECK TABLE products;`. Both should report status OK.

**Verify:** `ANALYZE TABLE products` reports `status OK`, and so does `CHECK TABLE products`.

---

> 🧪 Try it yourself first — then peek at the solutions in `../solutions/` to see how they're done.

Each task should leave the database **net-neutral**: drop any table you create, restore any setting you change (`long_query_time = 10`, `slow_query_log = OFF`).