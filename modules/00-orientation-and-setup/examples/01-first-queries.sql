-- Module 00 — your first queries against shopdb
-- Run with: python dbctl.py sql --file modules/00-orientation-and-setup/examples/01-first-queries.sql
SELECT VERSION();
SHOW DATABASES;
SHOW TABLES;
DESCRIBE persons;
SELECT COUNT(*) FROM persons;
SELECT first_name, last_name FROM persons ORDER BY person_id LIMIT 5;
