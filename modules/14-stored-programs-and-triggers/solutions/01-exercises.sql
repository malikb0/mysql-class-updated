-- Module 14 — Stored Programs & Triggers · Exercise Solutions
-- Run: python3 dbctl.py sql --file modules/14-stored-programs-and-triggers/solutions/01-exercises.sql

-- Task 1 — a procedure with IN and OUT parameters
DROP PROCEDURE IF EXISTS sp_ex_price_of;
DELIMITER //
CREATE PROCEDURE sp_ex_price_of(
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

CALL sp_ex_price_of(1, @price);
SELECT @price AS product_1_price;

-- Task 2 — a stored function used inside a query
DROP FUNCTION IF EXISTS fn_ex_order_total;
DELIMITER //
CREATE FUNCTION fn_ex_order_total(p_order_id INT)
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

SELECT order_id, fn_ex_order_total(order_id) AS order_total
FROM orders
ORDER BY order_id;

-- Task 3 — a trigger on throwaway practice tables
DROP TABLE IF EXISTS practice_audit;
DROP TABLE IF EXISTS practice_items;
CREATE TABLE practice_items (
  id    INT AUTO_INCREMENT PRIMARY KEY,
  label VARCHAR(40) NOT NULL
);
CREATE TABLE practice_audit (
  audit_id INT AUTO_INCREMENT PRIMARY KEY,
  action   VARCHAR(10) NOT NULL,
  label    VARCHAR(40) NOT NULL
);
DELIMITER //
CREATE TRIGGER trg_ex_items_ai
AFTER INSERT ON practice_items
FOR EACH ROW
BEGIN
  INSERT INTO practice_audit (action, label)
  VALUES ('INSERT', NEW.label);
END //
DELIMITER ;

INSERT INTO practice_items (label) VALUES ('espresso'), ('latte');
SELECT action, label
FROM practice_audit
ORDER BY audit_id;

-- Task 4 — error handling: SIGNAL in one procedure, caught by a HANDLER in another
DROP PROCEDURE IF EXISTS sp_ex_check_price;
DELIMITER //
CREATE PROCEDURE sp_ex_check_price(IN p_price DECIMAL(10,2))
BEGIN
  IF p_price <= 0 THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'price must be positive';
  END IF;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_ex_try_price;
DELIMITER //
CREATE PROCEDURE sp_ex_try_price(IN p_price DECIMAL(10,2), OUT p_result VARCHAR(40))
BEGIN
  DECLARE EXIT HANDLER FOR SQLEXCEPTION
    SET p_result = 'rejected by guard';
  SET p_result = 'accepted';
  CALL sp_ex_check_price(p_price);
END //
DELIMITER ;

CALL sp_ex_try_price(-1.00, @bad);
CALL sp_ex_try_price(2.50, @good);
SELECT @bad AS negative_price, @good AS positive_price;

-- Clean up every program (net-neutral) and confirm shopdb is unchanged.
DROP PROCEDURE IF EXISTS sp_ex_price_of;
DROP FUNCTION  IF EXISTS fn_ex_order_total;
DROP PROCEDURE IF EXISTS sp_ex_check_price;
DROP PROCEDURE IF EXISTS sp_ex_try_price;
DROP TRIGGER   IF EXISTS trg_ex_items_ai;
DROP TABLE     IF EXISTS practice_audit;
DROP TABLE     IF EXISTS practice_items;

SELECT
  (SELECT COUNT(*) FROM information_schema.routines WHERE routine_schema = 'shopdb') AS routines_left,
  (SELECT COUNT(*) FROM information_schema.triggers WHERE trigger_schema = 'shopdb') AS triggers_left,
  (SELECT COUNT(*) FROM information_schema.tables   WHERE table_schema   = 'shopdb') AS shopdb_tables;
