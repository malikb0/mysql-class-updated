# Module 07 — Subqueries, CTEs & Window Functions · Exercises

Each task: **goal → hint → verify**. Solutions live in `../solutions/` (try first!).

## Task 1 — Products priced above the average

**Goal:** Write a scalar subquery that lists every product whose `unit_price` is higher than the overall average price.

**Hint:** Use a scalar subquery: `SELECT * FROM products WHERE unit_price > (SELECT AVG(unit_price) FROM products);`.

**Verify:** You should get **5 rows**: Tote Bag, Ceramic Mug, Espresso Blend, Decaf, House Roast.

## Task 2 — Customers who bought a Merch product

**Goal:** Write an `IN` subquery that finds customers who placed at least one order for a product in category_id = 4 (Merch).

**Hint:** Join orders to order_items then products and filter by `category_id = 4`, or use an `EXISTS` correlated subquery:
```sql
SELECT DISTINCT p.first_name, p.last_name
FROM customers c
JOIN persons p ON c.person_id = p.person_id
WHERE EXISTS (
    SELECT 1 FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    JOIN products pr ON oi.product_id = pr.product_id
    WHERE o.customer_id = c.customer_id AND pr.category_id = 4
);
```

**Verify:** You should get **3 rows**: Bilal, Dana, and Fatima.

## Task 3 — Customers with no cancelled order

**Goal:** Use `NOT EXISTS` to find every customer who never placed a cancelled order.

**Hint:** Correlate the outer query:
```sql
SELECT DISTINCT p.first_name, p.last_name
FROM customers c
JOIN persons p ON c.person_id = p.person_id
WHERE NOT EXISTS (
    SELECT 1 FROM orders o WHERE o.customer_id = c.customer_id AND o.status = 'cancelled'
);
```

**Verify:** You should get **5 rows**: Aisha, Bilal, Chen, Dana, and Fatima.

## Task 4 — Order totals with ranking

**Goal:** Build a CTE that computes each order's total (`SUM(quantity * unit_price)`), then use the `RANK()` window function to rank orders by total descending (highest first).

**Hint:**
```sql
WITH ordered_totals AS (
    SELECT o.order_id, SUM(oi.quantity * oi.unit_price) AS total
    FROM orders o JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY o.order_id
)
SELECT order_id, total, RANK() OVER (ORDER BY total DESC) AS rank_num
FROM ordered_totals;
```

**Verify:** You should get **8 rows**. Order 7 is the top-ranked at 34.00.

> 🧪 Try it yourself before peeking — the CTE + window combination is a pattern worth remembering for real-world analytics.