-- 14 · Stored Programs & Triggers — worked example (net-neutral).
-- Run: python3 dbctl.py sql --file modules/14-stored-programs-and-triggers/examples/01-stored-programs-and-triggers.sql

-- Step 1 — no stored programs exist yet in shopdb.
SELECT routine_name, routine_type
FROM information_schema.routines
WHERE routine_schema = 'shopdb'
ORDER BY routine_name;

-- Step 2 — a procedure with an IN parameter and an OUT parameter.
DROP PROCEDURE IF EXISTS sp_price_of;
DELIMITER //
CREATE PROCEDURE sp_price_of(
  IN  p_product_id INT,
  OUT p_price      DECIMAL(10,2)
)
BEGIN
  SELECT unit_price
  INTO p_price
  FROM products
  WHERE product_id = p_product_id;
END //
DELIMITER ;

CALL sp_price_of(1, @price);
SELECT @price AS product_1_price;

-- Step 3 — a procedure that returns a result set filtered by its parameter.
DROP PROCEDURE IF EXISTS sp_products_under;
DELIMITER //
CREATE PROCEDURE sp_products_under(IN p_max DECIMAL(10,2))
BEGIN
  SELECT product_id, name, unit_price
  FROM products
  WHERE unit_price < p_max
  ORDER BY unit_price;
END //
DELIMITER ;

CALL sp_products_under(5.00);

-- Step 4 — a stored function. DETERMINISTIC + READS SQL DATA keep it legal on a
-- server with binary logging on (log_bin_trust_function_creators = 0).
DROP FUNCTION IF EXISTS fn_order_total;
DELIMITER //
CREATE FUNCTION fn_order_total(p_order_id INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
READS SQL DATA
BEGIN
  DECLARE v_total DECIMAL(10,2);
  SELECT COALESCE(SUM(quantity * unit_price), 0)
  INTO v_total
  FROM order_items
  WHERE order_id = p_order_id;
  RETURN v_total;
END //
DELIMITER ;

SELECT order_id, fn_order_total(order_id) AS order_total
FROM orders
ORDER BY order_id;

-- Step 5 — a trigger. It lives on throwaway practice tables, never on the real
-- shopdb tables, so the example stays net-neutral.
DROP TABLE IF EXISTS practice_audit;
DROP TABLE IF EXISTS practice_items;
CREATE TABLE practice_items (
  id    INT AUTO_INCREMENT PRIMARY KEY,
  label VARCHAR(40) NOT NULL
);
CREATE TABLE practice_audit (
  audit_id   INT AUTO_INCREMENT PRIMARY KEY,
  action     VARCHAR(10) NOT NULL,
  item_label VARCHAR(40) NOT NULL
);
DELIMITER //
CREATE TRIGGER trg_items_after_insert
AFTER INSERT ON practice_items
FOR EACH ROW
BEGIN
  INSERT INTO practice_audit (action, item_label)
  VALUES ('INSERT', NEW.label);
END //
DELIMITER ;

INSERT INTO practice_items (label) VALUES ('espresso'), ('latte');
SELECT action, item_label
FROM practice_audit
ORDER BY audit_id;

-- Step 6 — a scheduled event. It is created DISABLED, so nothing fires.
DROP EVENT IF EXISTS ev_purge_practice;
CREATE EVENT ev_purge_practice
ON SCHEDULE EVERY 1 DAY
STARTS CURRENT_TIMESTAMP + INTERVAL 1 DAY
ON COMPLETION PRESERVE
DISABLE
DO DELETE FROM practice_items WHERE label = 'nonexistent';

SELECT event_name, status, interval_value, interval_field
FROM information_schema.events
WHERE event_schema = 'shopdb';

-- Step 7 — error handling. sp_check_price raises an error with SIGNAL; the caller
-- sp_try_price catches it with an EXIT HANDLER instead of aborting the script.
DROP PROCEDURE IF EXISTS sp_check_price;
DELIMITER //
CREATE PROCEDURE sp_check_price(IN p_price DECIMAL(10,2))
BEGIN
  IF p_price <= 0 THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'price must be positive';
  END IF;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_try_price;
DELIMITER //
CREATE PROCEDURE sp_try_price(IN p_price DECIMAL(10,2), OUT p_result VARCHAR(40))
BEGIN
  DECLARE EXIT HANDLER FOR SQLEXCEPTION
    SET p_result = 'rejected by guard';
  SET p_result = 'accepted';
  CALL sp_check_price(p_price);
END //
DELIMITER ;

CALL sp_try_price(-1.00, @bad);
CALL sp_try_price(2.50, @good);
SELECT @bad AS negative_price, @good AS positive_price;

-- Step 8 — clean up every program (net-neutral) and confirm shopdb is unchanged.
DROP PROCEDURE IF EXISTS sp_price_of;
DROP PROCEDURE IF EXISTS sp_products_under;
DROP PROCEDURE IF EXISTS sp_check_price;
DROP PROCEDURE IF EXISTS sp_try_price;
DROP FUNCTION  IF EXISTS fn_order_total;
DROP TRIGGER   IF EXISTS trg_items_after_insert;
DROP EVENT     IF EXISTS ev_purge_practice;
DROP TABLE     IF EXISTS practice_audit;
DROP TABLE     IF EXISTS practice_items;

SELECT
  (SELECT COUNT(*) FROM information_schema.routines WHERE routine_schema = 'shopdb') AS routines_left,
  (SELECT COUNT(*) FROM information_schema.triggers WHERE trigger_schema = 'shopdb') AS triggers_left,
  (SELECT COUNT(*) FROM information_schema.events   WHERE event_schema   = 'shopdb') AS events_left,
  (SELECT COUNT(*) FROM information_schema.tables   WHERE table_schema   = 'shopdb') AS shopdb_tables;
