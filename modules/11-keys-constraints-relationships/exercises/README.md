# Module 11 — Keys, Constraints & Relationships · Exercises

Each task: **goal → hint → verify**. Solutions live in `../solutions/` (try first!).

## Task 1 — List the primary keys

**Goal:** find every table that has a primary key in `shopdb`.

**Hint:** query `information_schema.table_constraints` where `constraint_type = 'PRIMARY KEY'` and filter on `table_schema = 'shopdb'`.

**Verify:** exactly **10** rows — one for each of the 10 tables: addresses, categories, customers, employees, order_items, orders, payments, persons, products, stores.

## Task 2 — Cascade deletes

**Goal:** create a parent/child pair where deleting the parent automatically removes child rows.

**Hint:**
1. Create `practice_room` (room_id INT PRIMARY KEY, name VARCHAR UNIQUE).
2. Create `practice_booking` with:
   - booking_id INT as primary key
   - room_id INT as foreign key referencing practice_room ON DELETE CASCADE
   - guests SMALLINT CHECK(guests > 0)
3. Insert two rooms and three bookings (use different room_ids).
4. Delete one room entirely.

**Verify:** `SELECT COUNT(*) FROM practice_booking` returns **2** — the booking for the deleted room is gone too, thanks to CASCADE.

## Task 3 — Read the constraints

**Goal:** see what constraints your database actually enforces on those two practice tables.

**Hint:** query `information_schema.table_constraints` where table_name IN ('practice_room', 'practice_booking') and order by constraint_type, constraint_name.

**Verify:** exactly **5** rows:
| TABLE_NAME | CONSTRAINT_TYPE | CONSTRAINT_NAME |
|---|---|---|
| practice_booking | FOREIGN KEY | fk_practice_booking_room |
| practice_booking | PRIMARY KEY | PRIMARY |
| practice_booking | CHECK | chk_practice_booking_guests |
| practice_room | PRIMARY KEY | PRIMARY |
| practice_room | UNIQUE | name |

## Task 4 — Audit referential actions

**Goal:** every foreign key in `shopdb` has a delete rule and an update rule. Find them all.

**Hint:** query `information_schema.referential_constraints` where `constraint_schema = 'shopdb'`. Order by `constraint_name`, and exclude any of your own practice tables.

**Verify:** exactly **11** rows — and every single row has `delete_rule = 'NO ACTION'` and `update_rule = 'NO ACTION'`. This is the InnoDB default: it blocks deletes/updates on parent rows unless you explicitly change the rule.

## Wrap-up

Drop all your practice tables before returning so shopdb stays at 10 tables.

> 🧪 Try it — pick one task, write a solution in `../solutions/01-exercises.sql`, and run it with `python3 dbctl.py sql --file ../solutions/01-exercises.sql`. If the verify checks pass, you've got it.
