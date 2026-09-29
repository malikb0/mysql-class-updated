-- run-as: root
-- 21 · Capstone — Exercise Solutions (an end-to-end mini-project, net-neutral).
-- Run: python3 dbctl.py sql --file modules/21-capstone/solutions/01-exercises.sql

-- Task 1 — DESIGN: a small workshop-booking system.
DROP TABLE IF EXISTS practice_cw_bookings;

DROP TABLE IF EXISTS practice_cw_customers;

CREATE TABLE practice_cw_customers (
  customer_id INT AUTO_INCREMENT PRIMARY KEY,
  name        VARCHAR(60) NOT NULL,
  city        VARCHAR(60) NOT NULL
) ENGINE = InnoDB;

CREATE TABLE practice_cw_bookings (
  booking_id  INT AUTO_INCREMENT PRIMARY KEY,
  customer_id INT NOT NULL,
  session_on  DATE NOT NULL,
  seats       INT NOT NULL,
  fee         DECIMAL(8,2) NOT NULL,
  CONSTRAINT fk_practice_booking_customer FOREIGN KEY (customer_id) REFERENCES practice_cw_customers (customer_id)
) ENGINE = InnoDB;

-- Task 2 — SEED and QUERY: bookings and total fees per customer.
INSERT INTO practice_cw_customers (name, city) VALUES
  ('Giorgio Rossi', 'Milan'),
  ('Hana Sato',     'Osaka'),
  ('Igor Petrov',   'Prague');

INSERT INTO practice_cw_bookings (customer_id, session_on, seats, fee) VALUES
  (1, '2024-06-01', 2, 40.00),
  (1, '2024-06-15', 1, 20.00),
  (2, '2024-06-02', 4, 80.00),
  (3, '2024-06-20', 3, 60.00);

SELECT
  c.customer_id,
  c.name,
  COUNT(b.booking_id)  AS bookings,
  SUM(b.seats)         AS seats,
  ROUND(SUM(b.fee), 2) AS total_fee
FROM practice_cw_customers AS c
LEFT JOIN practice_cw_bookings AS b ON b.customer_id = c.customer_id
GROUP BY c.customer_id, c.name
ORDER BY total_fee DESC;

-- Task 3 — OPTIMISE: index the session date, then compare the plan.
EXPLAIN SELECT booking_id, customer_id, fee
FROM practice_cw_bookings
WHERE session_on >= '2024-06-10'
  AND session_on < '2024-07-01';

CREATE INDEX idx_practice_bookings_date ON practice_cw_bookings (session_on);

ANALYZE TABLE practice_cw_bookings;

EXPLAIN SELECT booking_id, customer_id, fee
FROM practice_cw_bookings
WHERE session_on >= '2024-06-10'
  AND session_on < '2024-07-01';

-- Task 4 — SECURE: a read-only reporting role, then tear everything down.
CREATE ROLE IF NOT EXISTS practice_cw_reader;

GRANT SELECT ON shopdb.practice_cw_customers TO practice_cw_reader;

GRANT SELECT ON shopdb.practice_cw_bookings TO practice_cw_reader;

SHOW GRANTS FOR practice_cw_reader;

DROP ROLE IF EXISTS practice_cw_reader;

DROP TABLE practice_cw_bookings;

DROP TABLE practice_cw_customers;

SELECT COUNT(*) AS shopdb_tables
FROM information_schema.tables
WHERE table_schema = 'shopdb';
