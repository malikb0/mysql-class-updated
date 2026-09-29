# Module 13 — Transactions & Concurrency

> **Level:** L3 · **Prereqs:** `12-indexes-and-views` · **Time:** ~2.5 h · **Original class(es):** Class 17

## Why this module

A transaction is a group of statements that must succeed or fail together — either all commit, or none do. It guarantees ACID: Atomic (all-or-nothing), Consistent (valid state throughout), Isolated (one session's changes stay invisible to others until committed), and Durable (changes survive crashes). Without transactions, a cash transfer could leave money in the destination bank without removing it from the source — the customer keeps their funds but no one else receives them.

Think of it like an airline booking: you can't partially book a flight. The seat must be reserved, the confirmation sent, and the fare charged all at once. If anything fails, everything rolls back — the passenger doesn't end up with a booked flight that nobody confirmed. That's what transactions do for your database.

> 🎯 Goal: By the end of this module you should be able to wrap operations in `START TRANSACTION` / `COMMIT`, undo them with `ROLLBACK`, and read locks on rows before updating them.

## What you'll learn

- Explain ACID and why `autocommit` makes every standalone statement its own transaction
- Wrap several statements in `START TRANSACTION … COMMIT`, and undo them all with `ROLLBACK`
- Undo **part** of a transaction with `SAVEPOINT` / `ROLLBACK TO SAVEPOINT`
- Read the session isolation level and change it, and take a row lock with `SELECT … FOR UPDATE`

## Prerequisites

```bash
make setup && make up && make seed
```

This creates the `shopdb` database with 12 persons, 6 customers, 2 stores,
5 employees, 4 categories, 10 products, 8 orders, 14 order items and 6 payments.

## What you'll run / build

You will execute a SQL script that demonstrates transactions — including committing a transfer of funds between customer accounts, rolling back a partial payment update using savepoints, and reading row locks so two sessions cannot update the same product quantity simultaneously. The script leaves exactly 10 tables in `shopdb`: all original seed data plus one new table created by the script itself (`blocked_transfer`), which contains records of transfers that were cancelled mid-transaction.

> ⚠️ Gotcha: Running the script does not modify any existing rows — every change is wrapped in a transaction and rolled back at the end so your seed database stays untouched.

## How to run it

```bash
python3 dbctl.py sql --file modules/13-transactions-and-concurrency/examples/01-transactions-and-concurrency.sql
```

This file is net-neutral — it does not use any external services or APIs, and after running the script you will find exactly 10 tables in `shopdb` (all original seed tables plus one new table).

## This folder

| File | Purpose |
|---|---|
| `README.md` (this guide) | overview and instructions |
| `notes.md` | concepts, worked example and common errors |
| `assets/transaction-flow.md` | a one-page transaction-flow memory aid |
| `examples/01-transactions-and-concurrency.sql` | runnable, net-neutral — do not edit |
| `exercises/README.md` | four practice tasks |
| `solutions/01-exercises.sql` | answers (try first!) |
| `checklist.md` | self-check items |

## Next

The next module is **Module 14 — Stored Programs & Triggers**, which introduces stored procedures, functions, and triggers. See the [Course Index](../../SYLLABUS.md) for the full list and what comes after.

[← Back to course index](../../SYLLABUS.md)