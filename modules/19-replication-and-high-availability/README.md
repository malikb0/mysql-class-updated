# Module 19 — Replication & High Availability

> **Level:** L4 · **Prereqs:** `18-server-administration-and-operations` · **Time:** ~2 h · **Original class(es):** new (gap)

## Why this module

If the café's only server is down, nobody can open an order. A second server kept in step turns a disaster into a simple pause — and that is exactly what replication gives you.

This module walks through primary/replica replication, GTID, read replicas and failover so you can explain every concept in your own words and stand up a real replica to watch changes copy across.

## What you'll learn

- Explain primary/replica replication and what the binary log sends
- Read this server's replication posture and its binary-log coordinates
- Stand up a real replica on a second MySQL server and watch a change copy across
- Explain GTID, async vs semi-sync, read replicas and the basics of failover

## Prerequisites

```bash
make setup && make up && make seed
```

This creates the `shopdb` database with 12 persons, 6 customers, 2 stores, 5 employees, 4 categories, 10 products, 8 orders, 14 order items and 6 payments.

> ⚠️ Gotcha: you'll also need Docker (it starts a second MySQL container for the replica).

## What you'll run / build

- A worked example in `notes.md` that reads this server's replication posture, binary-log coordinates and proves no replicas are connected yet
- A real replication drill that creates an account, takes a snapshot, stands up a second MySQL server as a replica and shows a change copying across
- Practice tasks that let you read replication state on your own machine

## How to run it

```bash
python3 dbctl.py sql --file modules/19-replication-and-high-availability/examples/01-replication-and-high-availability.sql
```

The file is net-neutral — it drops everything it creates and leaves the database with exactly 10 tables. It runs as the admin account (`root`) because reading replication state needs the `REPLICATION CLIENT` privilege.

## This folder

| File | Purpose |
|---|---|
| `README.md` (this guide) | overview and instructions |
| `notes.md` | concepts, worked example and common errors |
| `assets/replication.md` | primary vs replica, and the road to failover |
| `examples/01-replication-and-high-availability.sql` | runnable, net-neutral — do not edit |
| `exercises/README.md` | four practice tasks |
| `solutions/01-exercises.sql` | answers (try first!) |
| `checklist.md` | self-check items |

## Next

Next up is **Module 20 — MySQL from Applications**, where your SQL meets real application code.

- [Course index](../../SYLLABUS.md)