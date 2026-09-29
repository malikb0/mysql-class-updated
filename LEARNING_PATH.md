# Learning Path — how to study this course

## The L0→L4 route

Each level builds on the previous one. Work through the modules **in order** within a level; don't skip ahead.

| Level | Modules | What you'll be able to do by the end |
|-------|---------|--------------------------------------|
| **L0 — Orientation** | 00 | Run a MySQL server, connect from CLI or Workbench, create databases and users, write your first query |
| **L1 — Foundations** | 01–04 | Create tables (DDL), load data, run SELECT queries with filters/sorts, update/delete records safely |
| **L2 — Query power** | 05–09 | Aggregate data, join multiple tables, use subqueries/CTEs/window functions, apply built-in functions and choose correct types |
| **L3 — Design & integrity** | 10–13 | Model and normalise a schema, enforce constraints, create indexes and views, write transactional code |
| **L4 — Professional** | 14–21 | Write stored programs, manage security, tune queries, back up and replicate data, administer the server, connect from Python, ship an end-to-end system |

> At each level you'll find: a README (objectives), notes.md (concepts + worked example), examples/ (runnable SQL), exercises/ (+ solutions/) and checklist.md (self-check). Nothing to install beyond the repo's one-command setup — see [README](README.md).

## Fast tracks

Want something specific? Pick one of these routes. Each takes you from a starting point to a focused goal in about 6–8 hours total.

| Track | Start → End | Focus |
|-------|-------------|-------|
| **Weekend sprint** (L0→L2) | 00 → 06 | Core querying: tables, data, SELECT, aggregates, joins |
| **Interview prep** | 03 → 16 | SELECT/JOIN/AGGREGATE/WINDOW/INDEX — the common interview set |
| **Backend / ops** | 01 → 19 | DDL, constraints, indexes, transactions, security, backups, administration, replication |
| **Full course** (all) | 00 → 21 | Everything in order — about 2 h per module plus exercises |

## How to study a module

Every module follows the same shape:

1. **Read the README** — scan objectives and what you'll run.
2. **Skim notes.md** — get the concept, worked example, vocabulary, common errors.
3. **Run examples/** — execute each SQL file against your `shopdb`.
4. **Do exercises/** — attempt first; check answers in **solutions/** only after trying.
5. **Complete checklist.md** — verify yourself before moving on.

## Datasets you'll use

| Dataset | Purpose | Where it comes from |
|---------|---------|---------------------|
| `shopdb` (persons, addresses, customers, employees, products, orders…) | All modules | Synthetic CSVs + generated seed data built into this repo (`make seed`) |
| Sakila | Practice joins and routines | Oracle/MySQL sample DB — fetched via `python dbctl.py fetch sakila-db` |
| Employees (`test_db`) | Large-data tuning practice | datacharmer/test_db — fetched via `python dbctl.py fetch test_db` |

## Where to find everything

| Resource | Link |
|----------|------|
| Module syllabus | [SYLLABUS.md](SYLLABUS.md) |
| Original class transcripts | [docs/reference/legacy/](docs/reference/legacy/) |
| Attribution & credits | [NOTICE.md](NOTICE.md) |
