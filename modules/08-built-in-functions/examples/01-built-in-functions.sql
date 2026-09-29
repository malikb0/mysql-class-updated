-- Module 08: Built-in Functions — examples
-- Run with: python3 dbctl.py sql --file modules/08-built-in-functions/examples/01-built-in-functions.sql
-- Or via make:   make sql FILE=modules/08-built-in-functions/examples/01-built-in-functions.sql

-- Step 1: String building — glue two columns into one value
SELECT p.person_id,
       CONCAT(p.first_name, ' ', p.last_name) AS full_name,
       UPPER(p.last_name)                     AS last_upper,
       CHAR_LENGTH(p.email)                   AS email_len
FROM persons p
ORDER BY p.person_id;

-- Step 2: String slicing — pull the category code out of each SKU
SELECT pr.product_id,
       pr.sku,
       LEFT(pr.sku, 3)                   AS code,
       SUBSTRING_INDEX(pr.sku, '-', -1)  AS number
FROM products pr
ORDER BY pr.product_id;

-- Step 3: Reshape text — trim, replace and lower-case
SELECT TRIM('   House Roast   ')             AS trimmed,
       REPLACE('House Roast', ' ', '-')      AS slug,
       LOWER('ESP-LEND')                     AS lowered;

-- Step 4: Rounding the average price
SELECT ROUND(AVG(unit_price), 2) AS avg_2dp,
       ROUND(AVG(unit_price), 0) AS avg_whole,
       FLOOR(AVG(unit_price))    AS floored,
       CEIL(AVG(unit_price))     AS ceiled
FROM products;

-- Step 5: Handy numeric helpers
SELECT MOD(10, 3) AS remainder,
       ABS(-14.00) AS absolute,
       POWER(2, 5) AS two_to_five;

-- Step 6: Date parts — what day was each order placed?
SELECT order_id,
       DATE(order_date)      AS day,
       MONTHNAME(order_date) AS month_name,
       DAYNAME(order_date)   AS weekday,
       YEAR(order_date)      AS yr
FROM orders
ORDER BY order_id;

-- Step 7: Date arithmetic — add/remove days, find month end
SELECT DATE_ADD('2024-01-05', INTERVAL 7 DAY) AS plus_week,
       DATE_SUB('2024-01-05', INTERVAL 1 DAY) AS minus_day,
       LAST_DAY('2024-01-05')                 AS month_end;

-- Step 8: Age at a fixed reference date (deterministic)
SELECT first_name,
       dob,
       TIMESTAMPDIFF(YEAR, dob, '2024-01-01') AS age_at_2024
FROM persons
ORDER BY person_id;

-- Step 9: COALESCE — a fallback where a value can be missing
SELECT e.employee_id,
       CONCAT(p.first_name, ' ', p.last_name) AS employee,
       COALESCE(sup_p.first_name, '— none —') AS supervisor
FROM employees e
JOIN persons p           ON p.person_id = e.person_id
LEFT JOIN employees sup  ON sup.employee_id = e.supervisor_id
LEFT JOIN persons sup_p  ON sup_p.person_id = sup.person_id
ORDER BY e.employee_id;

-- Step 10: CASE — label each product with a price band
SELECT name,
       unit_price,
       CASE
         WHEN unit_price < 5.00  THEN 'budget'
         WHEN unit_price < 12.00 THEN 'mid'
         ELSE 'premium'
       END AS price_band
FROM products
ORDER BY unit_price, name;

-- Step 11: Conditional aggregation — one row with a count per status
SELECT SUM(CASE WHEN status = 'paid'      THEN 1 ELSE 0 END) AS paid,
       SUM(CASE WHEN status = 'shipped'   THEN 1 ELSE 0 END) AS shipped,
       SUM(CASE WHEN status = 'pending'   THEN 1 ELSE 0 END) AS pending,
       SUM(CASE WHEN status = 'cancelled' THEN 1 ELSE 0 END) AS cancelled
FROM orders;

-- Step 12: GROUP_CONCAT — one comma-separated list of products per category
SELECT c.name AS category,
       GROUP_CONCAT(pr.name ORDER BY pr.name SEPARATOR ', ') AS products
FROM categories c
JOIN products pr ON pr.category_id = c.category_id
GROUP BY c.category_id, c.name
ORDER BY c.category_id;
