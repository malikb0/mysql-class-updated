# Data

Source data used to build the course database. The seed in `sql/setup/` is generated from these files.

| File | Purpose |
|---|---|
| [dummy_data/dataPerson.csv](dummy_data/dataPerson.csv) | The owner's synthetic person records (name, date of birth, gender, email, phone) |
| [dummy_data/dataCustomers.csv](dummy_data/dataCustomers.csv) | Synthetic customer records linking people to join dates |
| [dummy_data/addresses.csv](dummy_data/addresses.csv) | Synthetic addresses |
| [dummy_data/persons.sql](dummy_data/persons.sql) | SQL load of the synthetic person data |

This is **original, synthetic data** created for the course — no real people. The schema and seed it feeds
are described in [docs/DATASETS.md](../docs/DATASETS.md).

> The larger public practice datasets used by a few modules (Sakila, Employees) are **fetched**, not stored
> here — run `python dbctl.py fetch`.
