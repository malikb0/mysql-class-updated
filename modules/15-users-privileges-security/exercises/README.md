# Module 15 — Users, Privileges & Security · Exercises

Each task: **goal → hint → verify**. Solutions live in `../solutions/` (try first!).

---

## Task 1 — Create a least-privilege account

**Goal:** Connect as the admin (`root`) and create an account `'report_reader'@'%'` that can only read every table in `shopdb`. Then inspect what you granted.

> 🎯 Goal:
> ```sql
> CREATE USER 'report_reader'@'%' IDENTIFIED BY 'ReadOnly_2024';
> GRANT SELECT ON shopdb.* TO 'report_reader'@'%';
> SHOW GRANTS FOR 'report_reader'@'%';
> ```

**Hint:** `CREATE USER` makes the login; `GRANT` decides what it may do. Give only `SELECT` — nothing else — so a leaked reporting account cannot change a single row.

**Verify:** `SHOW GRANTS` shows two lines — the account exists and holds exactly `SELECT` on `shopdb`:
```text
GRANT USAGE ON *.* TO `report_reader`@`%`
GRANT SELECT ON `shopdb`.* TO `report_reader`@`%`
```

---

## Task 2 — Wrap the access in a role

**Goal:** Create a role `'read_only'`, grant it `SELECT` on `shopdb`, then give the role to `'report_reader'@'%'` and make it the account's default role.

> 🎯 Goal:
> ```sql
> CREATE ROLE 'read_only';
> GRANT SELECT ON shopdb.* TO 'read_only';
> GRANT 'read_only' TO 'report_reader'@'%';
> SET DEFAULT ROLE 'read_only' TO 'report_reader'@'%';
> SHOW GRANTS FOR 'report_reader'@'%';
> ```

**Hint:** A role is a named bundle of privileges. Grant it once, hand it to many accounts, and manage access in one place instead of repeating `GRANT`s.

**Verify:** `SHOW GRANTS FOR 'report_reader'@'%'` now also shows the granted role:
```text
GRANT USAGE ON *.* TO `report_reader`@`%`
GRANT SELECT ON `shopdb`.* TO `report_reader`@`%`
GRANT `read_only`@`%` TO `report_reader`@`%`
```

---

## Task 3 — Add then revoke a privilege

**Goal:** Give the `'read_only'` role `INSERT` on `shopdb`, show the grants, then revoke `INSERT` and show them again.

> 🎯 Goal:
> ```sql
> GRANT INSERT ON shopdb.* TO 'read_only';
> SHOW GRANTS FOR 'read_only';
> REVOKE INSERT ON shopdb.* FROM 'read_only';
> SHOW GRANTS FOR 'read_only';
> ```

**Hint:** `GRANT` and `REVOKE` are mirror images — one adds a privilege, the other removes it. Revoking something the role does not have is harmless; always confirm with `SHOW GRANTS`.

**Verify:** the first `SHOW GRANTS` shows `SELECT, INSERT`; after the `REVOKE` only `SELECT` remains:
```text
GRANT USAGE ON *.* TO `read_only`@`%`
GRANT SELECT ON `shopdb`.* TO `read_only`@`%`
```

---

## Task 4 — A prepared statement

**Goal:** Build a prepared query over `products` with a `?` placeholder, bind the value `5.00`, and execute it.

> 🎯 Goal:
> ```sql
> PREPARE price_query FROM
>   'SELECT product_id, name, unit_price FROM products WHERE unit_price < ? ORDER BY unit_price';
> SET @max_price = 5.00;
> EXECUTE price_query USING @max_price;
> DEALLOCATE PREPARE price_query;
> ```

**Hint:** `PREPARE` parses the query once with a `?` placeholder; the value arrives later via `EXECUTE … USING`. The value is treated as **data**, never as SQL, so it cannot change the query's meaning.

**Verify:** two rows, cheapest first:
| product_id | name | unit_price |
|---|---|---|
| 8 | Muffin | 3.25 |
| 7 | Croissant | 3.75 |

---

> 🧪 Try it yourself first — then peek at the solutions in `../solutions/` to see how they're done.

**Net-neutral:** drop anything you create when you are done (`DROP USER IF EXISTS 'report_reader'@'%'; DROP ROLE IF EXISTS 'read_only';`) so the server is left exactly as you found it.
