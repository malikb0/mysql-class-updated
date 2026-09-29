# Module 17 — Backup & Recovery

> **Level:** L4 · **Prereqs:** `16-performance-and-query-tuning` · **Time:** ~2 h · **Original class(es):** Class 9 (extended)

## Why this module

Every café has a database of customers and orders, but data is only as useful as the last backup you can actually restore. A crash that wipes your hard drive or an accidental `DELETE ALL` are not just scary — they are preventable, provided you have a strategy for backing up shopdb regularly, testing that backups work, and knowing how to rewind the binary log so a bad transaction never touches real customers.

If a café cannot undo a bad `DELETE`, it stays closed. If it can restore from a verified backup and replay only the good part of the binary log, it keeps serving people and gets its doors back open. That is why this module matters: you will learn to treat the database as an asset you own, not as something that just works or breaks on its own.

## What you'll learn

- Explain the difference between a **logical** backup (`mysqldump`) and a **physical** backup
- Read the server's binary-log state with `SHOW BINARY LOG STATUS` and `SHOW BINARY LOGS`
- Run a real backup and a restore drill with `mysqldump` and the `mysql` client
- Explain how the binary log enables **point-in-time recovery**

## Prerequisites

```bash
make setup && make up && make seed
```

This creates the `shopdb` database with 12 persons, 6 customers, 2 stores,
5 employees, 4 categories, 10 products, 8 orders, 14 order items and 6 payments.

## What you'll run / build

You will create an automated backup script that dumps every `shopdb` table into a timestamped SQL file, then write a restore script that drops the database and re-imports from that dump. You will also experiment with stopping the server, deleting rows from a live customer table, restarting, and replaying the binary log to bring the customers back — showing how point-in-time recovery works in practice.

## How to run it

```bash
python3 dbctl.py sql --file modules/17-backup-and-recovery/examples/01-backup-and-recovery.sql
```

This file is net-neutral: every CREATE and DROP table is paired, so you can run the whole thing over a slow connection without leaving any extra tables behind. It reads binary-log state with `SHOW BINARY LOG STATUS` and `SHOW BINLOG STATUS`, which requires `root` (the server admin account) rather than the app user — connect as root to avoid "Access denied" on those commands.

## This folder

| File | Purpose |
|---|---|
| `README.md` (this guide) | overview and instructions |
| `notes.md` | concepts, worked example and common errors |
| `assets/backup-and-recovery.md` | logical vs physical backups at a glance |
| `examples/01-backup-and-recovery.sql` | runnable, net-neutral — do not edit |
| `exercises/README.md` | four practice tasks |
| `solutions/01-exercises.sql` | answers (try first!) |
| `checklist.md` | self-check items |

## Next

Module 18 — Server Administration & Operations. Continue the journey on [the course index](../../SYLLABUS.md).
