# Module 09 — Data Types & Precision · Exercises

Each task: **goal → hint → verify**. Solutions live in `../solutions/` (try first!).

---

## Task 1 — List every declared type of the `orders` table

**Goal:** find out what types the columns of `orders` are declared as.

**Hint:** use `information_schema.COLUMNS`. Filter by `TABLE_SCHEMA = 'shopdb'` and `TABLE_NAME = 'orders'`, order by `ORDINAL_POSITION`. Select only `COLUMN_NAME` and `COLUMN_TYPE`.

**Verify:** you should get **5 rows**.

---

## Task 2 — Find every `DECIMAL` column in the whole `shopdb` database

**Goal:** locate all columns whose declared type is a decimal/numeric type.

**Hint:** query `information_schema.COLUMNS` again, this time filtering by `DATA_TYPE = 'decimal'`. Order by `TABLE_NAME`, then `ORDINAL_POSITION`. Select `TABLE_NAME`, `COLUMN_NAME`, and `COLUMN_TYPE`.

**Verify:** you should get **3 rows**. (They are `order_items.unit_price`, `payments.amount`, and `products.unit_price`.)

---

## Task 3 — Characters vs bytes for a non-ASCII string

**Goal:** see how MySQL counts characters differently from bytes when the text contains multi-byte UTF-8 characters.

**Hint:** use `CHAR_LENGTH()` and `LENGTH()` on the same string with an explicit charset prefix, e.g. `_utf8mb4'naïve'`. The letter `ï` is two bytes in UTF-8 but one character.

**Verify:** you should get **1 row** with `5` chars and `6` bytes.

---

## Task 4 — Extract a field from a JSON document

**Goal:** pull the value of the `"sku"` key out of a JSON string stored as text.

**Hint:** use `JSON_EXTRACT()` to grab the path `$.sku`, then wrap it with `JSON_UNQUOTE()` so you get plain text rather than a quoted string. The sample JSON is `'{"sku":"MER-002","qty":3}'`.

**Verify:** you should get **1 row** with `sku = MER-002`.

---

> 🧪 Try it yourself first — then peek at the solutions in `../solutions/` to see how they're done.
