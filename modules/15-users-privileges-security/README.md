# Module 15 — Users, Privileges & Security

> **Level:** L4 · **Prereqs:** `14-stored-programs-and-triggers` · **Time:** ~2.5 h · **Original class(es):** new (gap)

## Why this module

A database does not have to be a single shared resource. When you create accounts, each account has its own login credentials and its own set of privileges — the permissions that say which tables can be read, written, or altered. That way different people get exactly the access they need: no more, no less.

In a café chain that matters every day. The payroll manager needs to see payments but should never touch orders; a reporting user may query data but cannot insert or delete rows; and the production application has only the rights to write what it writes. Least privilege is the guiding principle — grant exactly what each account must be able to do, nothing more.

## What you'll learn

- Explain accounts, roles and privileges, and what **least privilege** means
- Create an account and a role, and give or take away access with `GRANT` and `REVOKE`
- Read exactly what an account can do with `SHOW GRANTS`
- Use a prepared statement so user input can never change a query's meaning

## Prerequisites

Run this to set up the environment:

```bash
make setup && make up && make seed
```

This creates the `shopdb` database with 12 persons, 6 customers, 2 stores,
5 employees, 4 categories, 10 products, 8 orders, 14 order items and 6 payments.

## What you'll run / build

You will write SQL scripts that create accounts and roles, assign privileges, and demonstrate least-privilege access in a local MySQL instance running as root. You will also walk through a prepared statement example showing how user input is safely parameterised so it can never alter the query's meaning.

## How to run it

Execute your script with this command (replace the path if you edited anything):

```bash
python3 dbctl.py sql --file modules/15-users-privileges-security/examples/01-users-privileges-security.sql
```

The file is completely net-neutral — every account and role it creates is dropped at the end, so you can run it again without side effects. The script manages accounts itself, which means you need to connect as the admin user `root` rather than any application account.

## This folder

| File | Purpose |
|---|---|
| `README.md` (this guide) | overview and instructions |
| `notes.md` | concepts, worked example and common errors |
| `assets/privilege-model.md` | a one-page map of accounts, roles and privileges |
| `examples/01-users-privileges-security.sql` | runnable, net-neutral — do not edit |
| `exercises/README.md` | four practice tasks |
| `solutions/01-exercises.sql` | answers (try first!) |
| `checklist.md` | self-check items |

## Next

[Module 16 — Performance & Query Tuning](../../SYLLABUS.md)
