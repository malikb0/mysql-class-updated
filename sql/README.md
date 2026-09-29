# SQL setup

The SQL that builds the course database. Applied in filename order by `python dbctl.py seed`
(equivalently `make seed`).

| File | What it does |
|---|---|
| [setup/00-schema.sql](setup/00-schema.sql) | Creates the **10 `shopdb` tables** with primary keys, foreign keys and constraints |
| [setup/10-seed.sql](setup/10-seed.sql) | Inserts the **deterministic seed** (fixed row counts; see [DATASETS.md](../docs/DATASETS.md)) |

The numeric prefixes keep the order explicit. The seed is idempotent: it starts from a clean schema, so
`python dbctl.py reset` gives you the exact same `shopdb` every time.

## The 10 tables

`addresses` · `categories` · `customers` · `employees` · `order_items` · `orders` · `payments` ·
`persons` · `products` · `stores`

Full column lists and the seed counts are in [docs/DATASETS.md](../docs/DATASETS.md).
