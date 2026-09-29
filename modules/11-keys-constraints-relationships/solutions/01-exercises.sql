-- Module 11 — Keys, Constraints & Relationships · Exercise solutions.
-- Run:  python3 dbctl.py sql --file modules/11-keys-constraints-relationships/solutions/01-exercises.sql
-- Each task is runnable and net-neutral (the practice_* tables are dropped again at the end).

-- Task 1 — Every primary key in shopdb.
SELECT
  table_name,
  constraint_name
FROM information_schema.table_constraints
WHERE table_schema = 'shopdb'
  AND constraint_type = 'PRIMARY KEY'
ORDER BY table_name;

-- Task 2 — ON DELETE CASCADE: deleting a room removes its bookings.
DROP TABLE IF EXISTS practice_booking;

DROP TABLE IF EXISTS practice_room;

CREATE TABLE practice_room (
  room_id INT AUTO_INCREMENT PRIMARY KEY,
  name    VARCHAR(40) NOT NULL UNIQUE
);

CREATE TABLE practice_booking (
  booking_id INT AUTO_INCREMENT PRIMARY KEY,
  room_id    INT NOT NULL,
  guests     INT NOT NULL,
  CONSTRAINT chk_practice_booking_guests CHECK (guests > 0),
  CONSTRAINT fk_practice_booking_room
    FOREIGN KEY (room_id) REFERENCES practice_room (room_id)
    ON DELETE CASCADE
);

INSERT INTO practice_room (name) VALUES
  ('Espresso Room'),
  ('Roastery Loft');

INSERT INTO practice_booking (room_id, guests) VALUES
  (1, 4),
  (1, 2),
  (2, 6);

DELETE FROM practice_room
WHERE room_id = 2;

SELECT COUNT(*) AS bookings_after_cascade
FROM practice_booking;

-- Task 3 — Read the constraints for the two practice tables.
SELECT
  table_name,
  constraint_name,
  constraint_type
FROM information_schema.table_constraints
WHERE table_schema = 'shopdb'
  AND table_name IN ('practice_room', 'practice_booking')
ORDER BY table_name, constraint_type, constraint_name;

-- Task 4 — Audit every foreign key that ships with shopdb's referential actions.
SELECT
  constraint_name,
  delete_rule,
  update_rule
FROM information_schema.referential_constraints
WHERE constraint_schema = 'shopdb'
  AND constraint_name NOT LIKE 'fk_practice%'
ORDER BY constraint_name;

-- Clean up: drop the practice tables (net-neutral).
DROP TABLE IF EXISTS practice_booking;

DROP TABLE IF EXISTS practice_room;

SELECT COUNT(*) AS shopdb_tables
FROM information_schema.tables
WHERE table_schema = 'shopdb';
