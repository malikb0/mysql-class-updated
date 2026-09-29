-- run-as: root
-- 21 · Capstone — an end-to-end mini-project (net-neutral).
-- Design, seed, query, optimise, secure — then leave shopdb exactly as you found it.
-- Run: python3 dbctl.py sql --file modules/21-capstone/examples/01-capstone.sql

-- Step 1 — DESIGN: two related tables for a café loyalty programme.
DROP TABLE IF EXISTS practice_loyalty_visits;

DROP TABLE IF EXISTS practice_loyalty_members;

CREATE TABLE practice_loyalty_members (
  member_id INT AUTO_INCREMENT PRIMARY KEY,
  name      VARCHAR(60) NOT NULL,
  email     VARCHAR(120) NOT NULL,
  joined_on DATE NOT NULL
) ENGINE = InnoDB;

CREATE TABLE practice_loyalty_visits (
  visit_id   INT AUTO_INCREMENT PRIMARY KEY,
  member_id  INT NOT NULL,
  visited_at DATE NOT NULL,
  spend      DECIMAL(8,2) NOT NULL,
  CONSTRAINT fk_practice_visit_member FOREIGN KEY (member_id) REFERENCES practice_loyalty_members (member_id)
) ENGINE = InnoDB;

-- Step 2 — SEED: a few members and their visits.
INSERT INTO practice_loyalty_members (name, email, joined_on) VALUES
  ('Aisha Khan',  'aisha@example.com', '2024-01-05'),
  ('Bilal Ahmed', 'bilal@example.com', '2024-02-11'),
  ('Chen Wei',    'chen@example.com',  '2024-03-02'),
  ('Dana Ortiz',  'dana@example.com',  '2024-03-20');

INSERT INTO practice_loyalty_visits (member_id, visited_at, spend) VALUES
  (1, '2024-04-01', 12.50),
  (1, '2024-04-15', 8.00),
  (2, '2024-04-02', 10.00),
  (2, '2024-05-01', 14.00),
  (3, '2024-04-20', 3.75),
  (4, '2024-05-03', 18.00),
  (4, '2024-05-10', 9.00),
  (4, '2024-05-22', 7.50);

-- Step 3 — QUERY: visits and total spend per member.
SELECT
  m.member_id,
  m.name,
  COUNT(v.visit_id)      AS visits,
  ROUND(SUM(v.spend), 2) AS total_spend
FROM practice_loyalty_members AS m
LEFT JOIN practice_loyalty_visits AS v ON v.member_id = m.member_id
GROUP BY m.member_id, m.name
ORDER BY total_spend DESC;

-- Step 4 — OPTIMISE: the plan for a date-range lookup before any index.
EXPLAIN SELECT visit_id, member_id, spend
FROM practice_loyalty_visits
WHERE visited_at >= '2024-05-01'
  AND visited_at < '2024-06-01';

CREATE INDEX idx_practice_visits_date ON practice_loyalty_visits (visited_at);

ANALYZE TABLE practice_loyalty_visits;

-- Step 5 — the same query now uses the index (type = range).
EXPLAIN SELECT visit_id, member_id, spend
FROM practice_loyalty_visits
WHERE visited_at >= '2024-05-01'
  AND visited_at < '2024-06-01';

-- Step 6 — SECURE: a read-only role for the reporting tool, least privilege only.
CREATE ROLE IF NOT EXISTS practice_loyalty_reader;

GRANT SELECT ON shopdb.practice_loyalty_members TO practice_loyalty_reader;

GRANT SELECT ON shopdb.practice_loyalty_visits TO practice_loyalty_reader;

SHOW GRANTS FOR practice_loyalty_reader;

-- Step 7 — TEARDOWN: drop the role and both practice tables; shopdb stays at 10 tables.
DROP ROLE IF EXISTS practice_loyalty_reader;

DROP TABLE practice_loyalty_visits;

DROP TABLE practice_loyalty_members;

SELECT COUNT(*) AS shopdb_tables
FROM information_schema.tables
WHERE table_schema = 'shopdb';
