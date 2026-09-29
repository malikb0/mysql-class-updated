# NOTICE

## Origin

This repository grew out of a hands-on MySQL course the author taught to students,
class by class. The original class transcripts are preserved (sanitised) under
[`docs/reference/legacy/`](docs/reference/legacy/). The course content, the `shopdb`
schema, the examples, and the notes are the author's own work, released under the
MIT License (see [`LICENSE`](LICENSE)).

## Non-affiliation

This is an independent educational project. It is **not affiliated with, sponsored by,
or endorsed by** Oracle, MySQL, or any course provider. Product names are used only to
describe the tools the course teaches.

## Third-party datasets

These are **downloaded on demand** by `python dbctl.py fetch` (never committed to the
repository) and remain under their own licences:

| Dataset | Source | Licence / credit |
|---------|--------|------------------|
| **Sakila** sample database | Oracle / MySQL (`downloads.mysql.com/docs/sakila-db.zip`) | New BSD licence; © MySQL/Oracle |
| **Employees** sample database (`test_db`) | [datacharmer/test_db](https://github.com/datacharmer/test_db) (migrated from Launchpad) | Original data by Fusheng Wang & Carlo Zaniolo (Siemens); CC BY-SA 3.0 |

If a download is unavailable, `dbctl.py fetch` can copy from a local archive via the
`MYSQL_CLASS_ARCHIVE` environment variable. Downloaded data lives under `data/sakila/`
and `data/employees/`, which are gitignored.
