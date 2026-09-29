# Module 08 — Built-in Functions · Exercises

Each task: **goal → hint → verify**. Solutions live in `../solutions/` (try first!).

---

## Task 1 — Contact list with email domain

**Goal:** For every person, print the person ID, full name, and their email domain.

**Hint:** Use `CONCAT(first_name,' ',last_name)` for the full name; extract the domain from `email` with `SUBSTRING_INDEX(email,'@',-1)`. Order by `person_id`.

**Verify:** 12 rows — e.g. `Aisha Khan · example.com` … `Lena Fischer · example.com` (every domain is `example.com`).

---

## Task 2 — Price-band counts

**Goal:** Classify every product into a price band (`budget` <5.00, `mid` <12.00, else `premium`) and count how many products fall in each band.

**Hint:** Use a `CASE` expression (same logic as the worked example) aliased as `price_band`, then `COUNT(*) AS products`, grouped by that alias. Order by `price_band`.

**Verify:** 3 rows — `budget 2, mid 5, premium 3`.

---

## Task 3 — Order weekdays

**Goal:** For every order, print the order ID and the weekday name (e.g. "Friday", "Saturday").

**Hint:** Use `DAYNAME(order_date)` from the worked example. Order by `order_id`.

**Verify:** 8 rows — orders on Friday through Thursday in the January batch.

---

## Task 4 — Per-category product list

**Goal:** For every category, print its name and a comma-separated list of all products in that category (sorted alphabetically).

**Hint:** Use `GROUP_CONCAT(pr.name ORDER BY pr.name SEPARATOR ', ')` with a `JOIN categories c JOIN products pr ON pr.category_id=c.category_id`, grouping by both `c.category_id` and `c.name`. Order by `c.category_id`.

**Verify:** 4 rows, one per category (in `category_id` order: Coffee, Tea, Bakery, Merch).

---

> 🧪 Try it yourself before peeking at `../solutions/01-exercises.sql`. The solutions are written so you can run them with `python3 dbctl.py sql --file ../solutions/01-exercises.sql` and compare your output.
