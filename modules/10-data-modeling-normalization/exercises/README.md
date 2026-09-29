# Module 10 — Data Modeling & Normalization · Exercises

Each task: **goal → hint → verify**. Solutions live in `../solutions/` (try first!).

## Task 1 — Read the model

**Goal:** list every foreign key declared in `shopdb`.

```sql
SELECT
  table_name,
  constraint_name,
  referenced_table_name
FROM information_schema.key_column_usage
WHERE table_schema = 'shopdb'
  AND referenced_table_name IS NOT NULL
ORDER BY table_name, constraint_name;
```

**Verify:** the query returns exactly **11 rows**. If you get fewer, check that you filtered on `referenced_table_name IS NOT NULL` (primary keys have no referenced table).

> 🎯 **Goal:** understand the relationships before building anything.

## Task 2 — Normalise to 1NF

**Goal:** create an unnormalised table with repeating ingredient columns, then convert it to one row per ingredient.

```sql
CREATE TABLE practice_menu_flat (
    dish         VARCHAR(30),
    ingredient_1 VARCHAR(50) DEFAULT NULL,
    ingredient_2 VARCHAR(50) DEFAULT NULL,
    ingredient_3 VARCHAR(50) DEFAULT NULL
);

INSERT INTO practice_menu_flat VALUES
    ('Flat White',   'Espresso', 'Milk', NULL),
    ('Matcha Latte', 'Matcha',   'Milk', 'Honey');
```

Now convert it to a line table — one row per ingredient:

```sql
CREATE TABLE practice_menu_ingredient (
    dish       VARCHAR(30),
    ingredient VARCHAR(50) NOT NULL
);

INSERT INTO practice_menu_ingredient (dish, ingredient)
SELECT dish, ingredient_1 FROM practice_menu_flat WHERE ingredient_1 IS NOT NULL
UNION ALL
SELECT dish, ingredient_2 FROM practice_menu_flat WHERE ingredient_2 IS NOT NULL
UNION ALL
SELECT dish, ingredient_3 FROM practice_menu_flat WHERE ingredient_3 IS NOT NULL;
```

**Verify:** `practice_menu_ingredient` should hold exactly **5 rows** — one for each non-NULL ingredient.

> ⚠️ **Gotcha:** an `INSERT … SELECT` copies whatever the `SELECT` returns. If the count is off, check your `WHERE … IS NOT NULL` filters.

## Task 3 — Normalise to 2NF / 3NF

**Goal:** build a normalised model and join it back together.

```sql
CREATE TABLE practice_sku (
    sku_id INT PRIMARY KEY,
    name   VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE practice_order (
    order_id      INT PRIMARY KEY,
    customer_name VARCHAR(50) NOT NULL
);

CREATE TABLE practice_line (
    order_id INT,
    sku_id   INT,
    qty      INT NOT NULL,
    PRIMARY KEY (order_id, sku_id),
    CONSTRAINT fk_practice_line_order FOREIGN KEY (order_id) REFERENCES practice_order (order_id),
    CONSTRAINT fk_practice_line_sku   FOREIGN KEY (sku_id)   REFERENCES practice_sku (sku_id)
);
```

Insert the data:

```sql
INSERT INTO practice_sku VALUES
    (1, 'Espresso Blend'),
    (2, 'Croissant');

INSERT INTO practice_order VALUES
    (1, 'Aisha Khan'),
    (2, 'Bilal Ahmed');

INSERT INTO practice_line VALUES
    (1, 1, 2),
    (1, 2, 1),
    (2, 1, 1);
```

Join everything back together:

```sql
SELECT
    o.order_id,
    s.name AS product,
    l.qty
FROM practice_line AS l
JOIN practice_order AS o ON o.order_id = l.order_id
JOIN practice_sku AS s ON s.sku_id = l.sku_id
ORDER BY o.order_id, s.name;
```

**Verify:** the join returns exactly **3 rows**. If you get fewer, check your `ON` clauses — a missing join condition silently drops rows.

> 💡 **Aha:** every normal form is a step toward clarity — 1NF removes repeating groups, 2NF removes partial dependencies, 3NF removes transitive ones.

## Task 4 — Analyse the baseline model

**Goal:** write a query that returns each order's line count and total quantity from the **normalized** `shopdb` tables (not any practice table).

```sql
SELECT
    order_id,
    COUNT(*)      AS line_count,
    SUM(quantity) AS total_units
FROM order_items
GROUP BY order_id
ORDER BY order_id;
```

**Verify:** the query returns exactly **8 rows** — one per order. If you get fewer, check your `GROUP BY`.

> 🧪 **Try it:** after each task, run its verify step before moving on. It's your feedback loop.

## Clean up

Drop everything you created so the database returns to its clean state:

```sql
DROP TABLE IF EXISTS practice_line;
DROP TABLE IF EXISTS practice_order;
DROP TABLE IF EXISTS practice_sku;
DROP TABLE IF EXISTS practice_menu_ingredient;
DROP TABLE IF EXISTS practice_menu_flat;
```
