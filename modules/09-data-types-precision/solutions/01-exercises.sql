-- Module 09 — Data Types & Precision · Exercise Solutions
-- Run: python3 dbctl.py sql --file modules/09-data-types-precision/solutions/01-exercises.sql

-- Task 1 — List every declared column type in the orders table
SELECT COLUMN_NAME, COLUMN_TYPE
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = 'shopdb' AND TABLE_NAME = 'orders'
ORDER BY ORDINAL_POSITION;

-- Task 2 — Find every DECIMAL column across shopdb
SELECT TABLE_NAME, COLUMN_NAME, COLUMN_TYPE
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = 'shopdb' AND DATA_TYPE = 'decimal'
ORDER BY TABLE_NAME, ORDINAL_POSITION;

-- Task 3 — Characters vs bytes for a non-ASCII string (naïve has 5 chars but 6 UTF-8 bytes)
SELECT CHAR_LENGTH(_utf8mb4'naïve') AS chars,
       LENGTH(_utf8mb4'naïve')      AS bytes;

-- Task 4 — Extract the sku field from a JSON document
SELECT JSON_UNQUOTE(
         JSON_EXTRACT(CAST('{"sku":"MER-002","qty":3}' AS JSON), '$.sku')
       ) AS sku;
