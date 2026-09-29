# File catalog

A one-line description of every significant file, so you can find your way without grepping.

## Root

| File | Purpose |
|---|---|
| `README.md` | Course hub: badges, quickstart, course map, module index, documentation map |
| `SYLLABUS.md` | The 22-module syllabus (level, topics, prerequisites, original class mapping) |
| `LEARNING_PATH.md` | Suggested study routes (fast track, interview prep, backend/ops, full course) |
| `NOTICE.md` | Attribution, dataset credits, non-affiliation, safety notes |
| `LICENSE` | MIT licence |
| `Makefile` | Thin wrapper: `setup up down seed reset sql test examples verify docs` |
| `dbctl.py` | Stdlib-only CLI: `setup up down seed reset sql fetch test examples verify docs` |
| `docker-compose.yml` | MySQL 8 service (`shopdb-mysql`, host port 3310, named volume) |
| `mkdocs.yml` | Optional MkDocs Material site configuration |
| `requirements-docs.txt` | Dependencies for the optional MkDocs site |

## Infrastructure

| File | Purpose |
|---|---|
| `sql/setup/00-schema.sql` | Creates the 10 `shopdb` tables with keys and constraints |
| `sql/setup/10-seed.sql` | Deterministic seed data (fixed row counts) |
| `scripts/legacy_to_md.py` | Converts the original class transcripts to sanitised Markdown |
| `data/dummy_data/dataPerson.csv` | Owner's synthetic `persons` source data |
| `data/dummy_data/dataCustomers.csv` | Owner's synthetic `customers` source data |
| `data/dummy_data/addresses.csv` | Owner's synthetic `addresses` source data |
| `data/dummy_data/persons.sql` | SQL load of the synthetic person data |
| `assets/models/shopdb-model.mwb` | MySQL Workbench ER model of `shopdb` |

## Modules

Every module under `modules/NN-slug/` ships the same seven files:

| File | Purpose |
|---|---|
| `README.md` | Module overview, prerequisites, how to run, the folder's file list |
| `notes.md` | Teaching notes: concepts, vocabulary, worked example, common errors, try-it |
| `checklist.md` | Six "I can…" self-check items |
| `assets/<slug>.md` | One-page memory aid (a Mermaid diagram + the key tables) |
| `examples/01-<slug>.sql` | Runnable worked example — net-neutral |
| `exercises/README.md` | Four practice tasks (goal → hint → verify) |
| `solutions/01-exercises.sql` | Worked answers — net-neutral |

Module 20 (`20-mysql-from-applications`) additionally ships `app/query_shop.py` (the example Python
application) and `requirements-app.txt` (SQLAlchemy + PyMySQL).

| # | Module |
|---|---|
| 00 | `00-orientation-and-setup` |
| 01 | `01-creating-tables-ddl` |
| 02 | `02-loading-data` |
| 03 | `03-querying-select-filter-sort` |
| 04 | `04-changing-data-nulls` |
| 05 | `05-aggregation` |
| 06 | `06-joins` |
| 07 | `07-subqueries-ctes-window-functions` |
| 08 | `08-built-in-functions` |
| 09 | `09-data-types-precision` |
| 10 | `10-data-modeling-normalization` |
| 11 | `11-keys-constraints-relationships` |
| 12 | `12-indexes-and-views` |
| 13 | `13-transactions-and-concurrency` |
| 14 | `14-stored-programs-and-triggers` |
| 15 | `15-users-privileges-security` |
| 16 | `16-performance-and-query-tuning` |
| 17 | `17-backup-and-recovery` |
| 18 | `18-server-administration-and-operations` |
| 19 | `19-replication-and-high-availability` |
| 20 | `20-mysql-from-applications` |
| 21 | `21-capstone` |

## Docs

| File | Purpose |
|---|---|
| `docs/README.md` | Documentation hub — where to start |
| `docs/GETTING_STARTED.md` | Set up Docker + Python, seed the database, run an example |
| `docs/STRUCTURE.md` | Repository layout, the layers, and the conventions |
| `docs/FILE_CATALOG.md` | This file — the file inventory |
| `docs/DATASETS.md` | The `shopdb` schema, the deterministic seed, and the practice datasets |
| `docs/GLOSSARY.md` | The MySQL vocabulary used across the course |
| `docs/STUDY_GUIDE.md` | How to study the course effectively |
| `docs/reference/legacy/` | Sanitised original class transcripts (17 classes) + `README.md` |
