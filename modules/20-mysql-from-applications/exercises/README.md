# Module 20 — MySQL from Applications · Exercises

Each task: **goal → hint → verify**. Solutions live in `../solutions/` (try first!).

---

## Task 1 — Read the connection's identity and the idle timeout

> 🎯 Goal: Find out who the current connection is, which database it's talking to, and how long an idle connection survives before being closed.
> 
> ⚠️ Gotcha: The values for `@wait_timeout` and `max_connections` are server settings — you're just reading them back; don't try to change them here.

```sql
SELECT
  CONNECTION_ID() AS connection_id,
  USER()          AS authenticated_as,
  DATABASE()      AS current_db;
```

**Verify:** `authenticated_as = shop@localhost` and `current_db = shopdb`; `@@wait_timeout = 28800` and `@@max_connections = 151`.

---

## Task 2 — A server-side prepared statement, reused

> 🎯 Goal: Prepare one statement with a `?` placeholder, run it with two different category values, then release it.
> 
> ⚠️ Gotcha: You must remember to call `DEALLOCATE PREPARE by_category;` at the end — otherwise the server keeps the prepared statement around and you'll get an error if you prepare another one with the same name.

```sql
PREPARE by_category FROM 'SELECT product_id, name, unit_price FROM products WHERE category_id = ? ORDER BY product_id';
```

**Verify:** category 3 returns Croissant (3.75) and Muffin (3.25); category 4 returns Ceramic Mug (14.00) and Tote Bag (18.00); finish with `DEALLOCATE PREPARE by_category;`.

---

## Task 3 — List the client connections

> 🎯 Goal: See every session the server can see, including your own connection as `shop` to `shopdb`.
> 
> ⚠️ Gotcha: The `time` column shows how long each thread has been running. Your value will be small since you just started; others may be larger if multiple people are connected.

```sql
SELECT
  id,
  user,
  host,
  db,
  command,
  time
FROM information_schema.processlist
ORDER BY id;
```

**Verify:** at least one row with `user = 'shop'` and `db = 'shopdb'`.

---

## Task 4 — Run the example app and change the parameter

> 🎯 Goal: Run the Python application, then modify its category parameter to see different products.
> 
> ⚠️ Gotcha: To change the category, edit `{"cat": 1}` to `{"cat": 2}` inside `app/query_shop.py`, then run it again — the app has no command-line parameter of its own.

```sql
SELECT product_id, name, unit_price FROM products WHERE category_id = 2 ORDER BY product_id;
```

**Verify:** the second run prints Green Tea, Earl Grey and Chai instead of the category-1 products, and still ends with `shopdb tables: 10`.

---

> 🧪 Try it yourself first — then peek at the solutions in `../solutions/` to see how they're done.
> 
> Drop any practice table you create so the database stays net-neutral (leaves exactly 10 tables).
