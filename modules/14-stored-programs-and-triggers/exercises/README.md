# Module 14 — Stored Programs & Triggers · Exercises

Each task: **goal → hint → verify**. Solutions live in `../solutions/` (try first!).

---

## Task 1 — Procedure with an IN and an OUT parameter

> 🎯 Goal — Create a procedure that returns the price of one product through
> an `OUT` parameter, call it for product ID 1, and select the parameter.

```sql
CREATE PROCEDURE get_product_price(
    IN pid INT,
    OUT pprice DECIMAL(10,2)
)
BEGIN
    SELECT unit_price INTO pprice
    FROM products WHERE product_id = pid;
END;
```

> ⚠️ Hint — Use `CALL` followed by a user variable: `CALL get_product_price(1, @p); SELECT @p AS product_1_price;`.

> 🧪 Try it yourself first. Then peek at the solution in [`../solutions/01-exercises.sql`](../solutions/01-exercises.sql) to see how it's done.

**Verify:** `product_1_price = 12.50`

---

## Task 2 — A stored function

> 🎯 Goal — Create a function that returns the total amount of items in an order,
> then use it in a `SELECT` to show totals for orders 1 and 7.

```sql
CREATE FUNCTION get_order_total(oid INT) RETURNS DECIMAL(10,2)
READ_ONLY
DETERMINISTIC
BEGIN
    RETURN (SELECT SUM(quantity * unit_price) FROM order_items WHERE order_id = oid);
END;
```

> 💡 Aha — `ORDER BY` sorts the results so you can read them left-to-right. The function is **read-only** and **deterministic**, which means it won't cause unexpected side-effects or prevent parallel execution.

> 🧪 Try it yourself first. Then peek at the solution in [`../solutions/01-exercises.sql`](../solutions/01-exercises.sql) to see how it's done.

**Verify:** order 1 totals `28.75`, order 7 totals `34.00`.

| Total |
|---|
| `28.75` |
| `34.00` |

---

## Task 3 — A trigger on a `practice_*` table

> 🎯 Goal — Create a `practice_products_audit` table with columns `(id INT, product_name VARCHAR(80), action_type VARCHAR(20))`. Write an `AFTER INSERT` trigger that copies the label into the audit table. Insert `espresso` and `latte`, then read the audit table.

```sql
CREATE TABLE practice_products (product_name VARCHAR(80));

CREATE TABLE practice_products_audit (id INT, product_name VARCHAR(80), action_type VARCHAR(20));

CREATE TRIGGER trg_insert_product AFTER INSERT ON practice_products FOR EACH ROW BEGIN
    INSERT INTO practice_products_audit (action_type) VALUES ('INSERT');
END;
```

> 🎯 Goal — Think about how the trigger fires once per row. You don't need to write an `INSERT` into the audit table inside the trigger body — MySQL can do it automatically with a column default, but here we keep it explicit so you see exactly what happens on each insert.

**Verify:** two rows — `espresso`, then `latte`.

| product_name | action_type |
|---|---|
| `espresso` | INSERT |
| `latte`    | INSERT |

> ⚠️ Gotcha — Don't forget to drop your practice tables after the task finishes. Net-neutral means no leftover artefacts.

**Drop at end:** `DROP TABLE IF EXISTS practice_products; DROP TABLE IF EXISTS practice_products_audit;`

---

## Task 4 — Catch an error with a handler

> 🎯 Goal — Create one procedure that raises an error when a price is less than or equal to zero, and a second procedure that calls it inside an `EXIT HANDLER FOR SQLEXCEPTION`, storing either `'rejected by guard'` or `'accepted'` into an `OUT` parameter. Call it with `-1.00` and `2.50`.

```sql
CREATE PROCEDURE price_check(
    IN pprice DECIMAL(10,2),
    OUT result VARCHAR(30)
)
BEGIN
    IF pprice <= 0 THEN SIGNAL SQLSTATEMENTERROR;
    ELSE SET result = 'accepted';
    END IF;
END;

CREATE PROCEDURE safe_price_check(
    IN pprice DECIMAL(10,2),
    OUT result VARCHAR(30)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION SET result = 'rejected by guard';
    CALL price_check(pprice, @r);
    SET result = @r;
END;
```

> 💡 Aha — `EXIT HANDLER` catches the exception and lets you keep the procedure running instead of aborting. It's how you build your own validation logic around MySQL's built-in checks.

**Verify:** the `-1.00` call gives `rejected by guard`; the `2.50` call gives `accepted`.

| result |
|---|
| `rejected by guard` |
| `accepted`  |

> 🧪 Try it yourself first — then peek at the solutions in [`../solutions/01-exercises.sql`](../solutions/01-exercises.sql) to see how they're done.

Each task should leave the database net-neutral: drop anything you create so there are no leftover artefacts between tasks or subsequent work.
