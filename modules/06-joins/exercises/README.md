# Module 06 — Joins · Exercises

Each task: **goal → hint → verify**. Solutions live in `../solutions/` (try first!).

## Task 1 — Every product with its category name

**Goal:** list every product's name, unit price, and the associated category name. Order by product name ascending.

**Hint:** the `products` table stores a foreign key (`category_id`) that points into `categories`. Join them on that key:
```sql
SELECT p.name AS product_name, p.unit_price, c.name AS category_name
FROM products p
JOIN categories c ON p.category_id = c.category_id
ORDER BY p.name;
```

**Verify:** the result should contain exactly one row per product.
```sql
SELECT COUNT(*) FROM products JOIN categories ON products.category_id = categories.category_id;  -- expect 10
```

## Task 2 — Every person and their city

**Goal:** list every person's first name alongside their address city. People without an address should still appear (with `NULL` for the city).

**Hint:** use a `LEFT JOIN`. Join from `persons` to `addresses` on `person_id`:
```sql
SELECT p.first_name, a.city AS city
FROM persons p
LEFT JOIN addresses a ON p.person_id = a.person_id;
```

**Verify:** every person should be present.
```sql
SELECT COUNT(*) FROM persons LEFT JOIN addresses ON persons.person_id = addresses.person_id;  -- expect 12
```

## Task 3 — Employees who manage nobody (anti-join)

**Goal:** list employees who are **not** anyone's supervisor. In other words, find the "leaf" employees in the supervision chain.

**Hint:** `employees.supervisor_id` references another row in `employees`. Left-join the table to itself on that key, then keep rows where the right side is `NULL`:
```sql
SELECT e.employee_id, p.first_name AS employee_name, e.role
FROM employees e
LEFT JOIN employees sup ON e.supervisor_id = sup.employee_id
LEFT JOIN persons p ON e.person_id = p.person_id
WHERE sup.employee_id IS NULL;
```

**Verify:** expected **3 rows** — employees 2, 4, and 5.
```sql
SELECT COUNT(*) FROM employees e LEFT JOIN employees s ON e.supervisor_id = s.employee_id WHERE s.employee_id IS NULL;  -- expect 3
```

## Task 4 — How many line items each order has (reuses Module 05 `GROUP BY`)

**Goal:** for every order, show the number of `order_items` rows that belong to it. Orders with zero items should still appear.

**Hint:** join `orders` to `order_items`, then group and count:
```sql
SELECT o.order_id, COUNT(oi.order_item_id) AS line_items
FROM orders o
LEFT JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY o.order_id;
```

**Verify:** expected **8 rows**; the counts should be 2, 2, 2, 1, 2, 1, 3, 1.
```sql
SELECT COUNT(*) FROM orders LEFT JOIN order_items ON orders.order_id = order_items.order_id GROUP BY orders.order_id;  -- expect 8
```

> 🧪 Try it: pick any join above and change `JOIN` to `LEFT JOIN`. What rows do you think will appear or disappear? Run the modified query before guessing — it's a great way to build intuition about how joins behave.
