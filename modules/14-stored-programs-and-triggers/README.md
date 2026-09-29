# Module 14 — Stored Programs & Triggers

> **Level:** L4 · **Prereqs:** `13-transactions-and-concurrency` · **Time:** ~2.5 h · **Original class(es):** Class 17

## Why this module

A stored program is SQL logic that lives inside the database — a procedure, function, trigger, or event. It runs when you call it, or when data matches its condition. Because the code lives in one place (the database), every application shares exactly the same rules instead of copying them across three different languages.

Think about Aisha at her café: she swipes on the terminal and the system needs to check the customer's balance, update the order status, log payment, and send a receipt — four separate queries that must all succeed or all fail. That logic is easier to maintain when it lives in one stored procedure than scattered across Java, Python, and PHP. If Aisha wants her store to automatically adjust the price of "House Roast" after every new product order, a trigger handles that without any human intervention.

## What you'll learn

- Explain what procedures, functions, triggers and events are, and when each one runs
- Create a procedure with `IN` and `OUT` parameters and run it with `CALL`
- Write a stored function and use it inside a `SELECT`
- Attach a trigger to a table, and raise and catch errors with `SIGNAL` and a `HANDLER`

## Prerequisites

```bash
make setup && make up && make seed
```

This creates the `shopdb` database with 12 persons, 6 customers, 2 stores, 5 employees, 4 categories, 10 products, 8 orders, 14 order items and 6 payments. You already know how to write joins, subqueries, window functions, transactions, and indexes from the earlier modules — this module builds on that knowledge but introduces new syntax.

## What you'll run / build

- A stored procedure that moves a customer's orders from one store to another (the `move_orders` example)
- A function that computes an order's total items across all its line items (`total_items_in_order`)
- Triggers on the `orders` table: automatic audit logging and cancellation checks — `audit_order_status_change` and `check_cancelled_order_amount`

## How to run it

```bash
python3 dbctl.py sql --file modules/14-stored-programs-and-triggers/examples/01-stored-programs-and-triggers.sql
```

This file is net-neutral: it creates every procedure, function, and trigger it demonstrates, then drops them all before finishing. It leaves the 10 `shopdb` tables intact. The output matches the result sets shown in the examples — if yours differs, check that you are running against this exact database.

## This folder

| File | Purpose |
|---|---|
| `README.md` (this guide) | overview and instructions |
| `notes.md` | concepts, worked example and common errors |
| `assets/stored-programs-map.md` | a one-page map of the four program types |
| `examples/01-stored-programs-and-triggers.sql` | runnable, net-neutral — do not edit |
| `exercises/README.md` | four practice tasks |
| `solutions/01-exercises.sql` | answers (try first!) |
| `checklist.md` | self-check items |

## Next

Module 15 covers users, privileges, and security — creating accounts, granting access to specific tables, and using views and functions with privilege checks. [Back to the course index](../../SYLLABUS.md).
