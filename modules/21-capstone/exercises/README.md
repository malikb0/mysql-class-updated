# Module 21 — Capstone · Exercises

Each task: **goal → hint → verify**. Solutions live in `../solutions/` (try first!).

---

## Task 1 — Design a small schema

> 🎯 Goal: Create two related tables with a foreign key constraint. The customers table holds people, and bookings link each customer to specific sessions they attend. Use `practice_*` names so you can drop them later without affecting `shopdb`.

```sql
CREATE TABLE practice_cw_customers (
  customer_id INT AUTO_INCREMENT PRIMARY KEY,
  name        VARCHAR(60) NOT NULL,
  city        VARCHAR(60) NOT NULL
) ENGINE = InnoDB;
```

> ⚠️ Gotcha: If you forget `ENGINE = InnoDB`, the foreign key won't work — MySQL requires InnoDB for constraints. And an `AUTO_INCREMENT` column must be a key, so keep `PRIMARY KEY` on it.

**Verify:** `SHOW TABLES LIKE 'practice_cw%';` lists `practice_cw_customers` and `practice_cw_bookings`, and the bookings table has a foreign key to the customers table.

---

## Task 2 — Seed and query

> 🎯 Goal: Insert three customers and four bookings, then report each customer's booking count, total seats booked, and sum of fees with a `LEFT JOIN` and `GROUP BY`. The output should show Hana Sato has 1 booking, 4 seats, 80.00; Giorgio Rossi has 2 bookings, 3 seats, 60.00.

```sql
SELECT
  c.customer_id,
  c.name,
  COUNT(b.booking_id)  AS bookings,
  SUM(b.seats)         AS seats,
  ROUND(SUM(b.fee), 2) AS total_fee
FROM practice_cw_customers AS c
LEFT JOIN practice_cw_bookings AS b ON b.customer_id = c.customer_id
GROUP BY c.customer_id, c.name
ORDER BY total_fee DESC;
```

> 💡 Aha: `LEFT JOIN` ensures every customer appears in the result even if they have zero bookings. Without it, customers with no bookings would be silently omitted.

**Verify:** Hana Sato has 1 booking, 4 seats, 80.00; Giorgio Rossi has 2 bookings, 3 seats, 60.00.

---

## Task 3 — Optimise

> 🎯 Goal: Read the query plan for a date-range lookup before adding an index, then add an index on `session_on` and read the plan again. The type should change from `ALL` to `range`.

```sql
EXPLAIN SELECT booking_id, customer_id, fee
FROM practice_cw_bookings
WHERE session_on >= '2024-06-10'
  AND session_on < '2024-07-01';
```

> ⚠️ Gotcha: After adding the index and running `ANALYZE TABLE`, you must run `EXPLAIN` again to see the new plan. The statistics update is what tells MySQL about the index's selectivity.

**Verify:** before the index `type = ALL` with `rows = 4`; after `CREATE INDEX idx_practice_bookings_date ON practice_cw_bookings (session_on)` and `ANALYZE TABLE`, `type = range`, `key = idx_practice_bookings_date`, `rows = 2`.

---

## Task 4 — Secure and tear down

> 🎯 Goal: Create a read-only role that can `SELECT` from both practice tables, show its grants to confirm least privilege, then drop the role and both tables. The database must end with exactly 10 tables — net-neutral.

```sql
SHOW GRANTS FOR practice_cw_reader;
```

> 💡 Aha: The role's grants should include `SELECT` on both `practice_cw_customers` and `practice_cw_bookings`. After teardown, confirm `shopdb` has exactly 10 tables by counting in `information_schema.tables`.

**Verify:** the role's grants include `SELECT` on both `practice_cw_customers` and `practice_cw_bookings`; after teardown, `shopdb` has exactly 10 tables.

---

> 🧪 Try it yourself first — then peek at the solutions in `../solutions/` to see how they're done.

Each task should leave the database **net-neutral** (drop every practice table and role). The final count must be exactly 10 tables in `shopdb`.
