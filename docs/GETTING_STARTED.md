# Getting started

Everything runs locally with **Docker** — no cloud, no account, no install of MySQL itself. You need:

- **Docker** (with Compose v2) — [docs.docker.com](https://docs.docker.com)
- **Python 3.10+** — for the `dbctl.py` helper (its only dependency is the standard library)
- **GNU Make** — optional; every `make` target has a `python dbctl.py …` equivalent.

## 1. Start the database

```bash
make setup      # validates the Compose config and the network
make up         # starts the MySQL 8 container (host port 3310)
make seed       # applies sql/setup/00-schema.sql + 10-seed.sql
```

Without `make`:

```bash
python dbctl.py setup
python dbctl.py up
python dbctl.py seed
```

`make seed` creates the course database **`shopdb`** with exactly **10 tables**, seeded deterministically:
12 persons · 12 addresses · 6 customers · 2 stores · 5 employees · 4 categories · 10 products · 8 orders ·
14 order items · 6 payments.

## 2. Check it works

```bash
python dbctl.py verify                       # container health + row counts
python dbctl.py sql --sql "SELECT COUNT(*) FROM orders"   # → 8
```

## 3. Work through a module

Each module lives in `modules/NN-slug/` and follows the same shape (see [STRUCTURE.md](STRUCTURE.md)).
Run its example:

```bash
make sql FILE=modules/03-querying-select-filter-sort/examples/01-select-and-filter.sql
```

Read `modules/NN-slug/notes.md` for the concepts, then do `exercises/README.md` and check `solutions/`.
The full curriculum is in [SYLLABUS.md](../SYLLABUS.md); a suggested route is in
[LEARNING_PATH.md](../LEARNING_PATH.md).

## 4. The content↔infra check

Every module's `.sql` must run against a freshly seeded `shopdb` and leave it net-neutral (10 tables):

```bash
python dbctl.py examples                     # runs every modules/**/*.sql
```

The full repository gate (links, Mermaid renders, secrets scan, ASCII-table ban, seed counts):

```bash
RUN_SQL=1 bash .orchestrator/scripts/verify-readiness.sh
```

## 5. Stop / reset

```bash
python dbctl.py reset     # drop and re-apply schema + seed (fast, idempotent)
python dbctl.py down      # stop the container (the data volume is kept)
```

## Troubleshooting

| Symptom | Cause / fix |
|---|---|
| `Can't connect to MySQL server on '127.0.0.1' (port 3310)` | the container is not up — `make up`, then wait for healthy |
| `Access denied for user 'shop'` | credentials come from `.env` (gitignored); defaults are in `.env.example` |
| port 3310 already in use | set `MYSQL_PORT` in `.env` to a free port and re-run `make up` |
| `make` not found | use the `python dbctl.py …` equivalents |

## Where to next

- [STRUCTURE.md](STRUCTURE.md) — how the repository is laid out
- [DATASETS.md](DATASETS.md) — the `shopdb` schema, the seed, and the practice datasets
- [GLOSSARY.md](GLOSSARY.md) — the vocabulary used across the course
- [STUDY_GUIDE.md](STUDY_GUIDE.md) — how to study the course effectively
