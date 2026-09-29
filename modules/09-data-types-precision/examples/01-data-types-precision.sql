-- Module 09: Data Types & Precision — examples
-- Run with: python3 dbctl.py sql --file modules/09-data-types-precision/examples/01-data-types-precision.sql
-- Or via make:   make sql FILE=modules/09-data-types-precision/examples/01-data-types-precision.sql

-- Step 1: DECIMAL is exact — 0.1 + 0.2 really is 0.3
SELECT 0.1 + 0.2 AS decimal_sum;

-- Step 2: Approximate FLOAT/DOUBLE is not exact
SELECT CAST(0.1 AS DOUBLE) + CAST(0.2 AS DOUBLE) AS double_sum;

-- Step 3: Money lives in DECIMAL(10,2) — read the declared type
SELECT COLUMN_NAME, COLUMN_TYPE, NUMERIC_PRECISION, NUMERIC_SCALE, IS_NULLABLE
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = 'shopdb'
  AND TABLE_NAME = 'products'
  AND COLUMN_NAME = 'unit_price';

-- Step 4: Round to a chosen scale with DECIMAL
SELECT CAST(10 / 3 AS DECIMAL(6,2)) AS third_2dp,
       ROUND(10 / 3, 4)             AS third_4dp;

-- Step 5: A SUM of DECIMAL values stays exact
SELECT SUM(quantity * unit_price) AS total
FROM order_items;

-- Step 6: CHAR_LENGTH vs LENGTH — characters vs bytes (UTF-8 accent)
SELECT CHAR_LENGTH(_utf8mb4'café') AS chars,
       LENGTH(_utf8mb4'café')      AS bytes;

-- Step 7: Integer widths — read the declared types from the catalog
SELECT TABLE_NAME, COLUMN_NAME, COLUMN_TYPE
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = 'shopdb'
  AND COLUMN_NAME IN ('is_active', 'quantity')
ORDER BY TABLE_NAME, COLUMN_NAME;

-- Step 8: ENUM is a constrained string — see the allowed values
SELECT COLUMN_NAME, COLUMN_TYPE
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = 'shopdb'
  AND TABLE_NAME = 'orders'
  AND COLUMN_NAME = 'status';

-- Step 9: The temporal family — DATE vs DATETIME
SELECT CAST('2024-01-05' AS DATE)            AS as_date,
       CAST('2024-01-05 09:15:00' AS DATETIME) AS as_datetime;

-- Step 10: JSON is a first-class type
SELECT CAST('{"name":"Aisha","tier":"gold"}' AS JSON) AS doc,
       JSON_UNQUOTE(JSON_EXTRACT(CAST('{"name":"Aisha","tier":"gold"}' AS JSON), '$.tier')) AS tier,
       JSON_UNQUOTE(JSON_EXTRACT(CAST('{"name":"Aisha","tier":"gold"}' AS JSON), '$.name')) AS name;
