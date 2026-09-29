# Datasets

The whole course runs on **one purpose-built database, `shopdb`**, created from this repository's own
schema and seed. Two larger public databases are available for optional practice.

## `shopdb` — the course database

A small café-chain business: people, stores, employees, products, orders and payments.

### Schema (10 tables)

| Table | Columns |
|---|---|
| `persons` | `person_id` · `first_name` · `last_name` · `dob` · `gender` · `email` · `phone` · `created_at` |
| `addresses` | `address_id` · `person_id` · `street` · `city` · `region` · `postal_code` · `country` · `is_primary` |
| `customers` | `customer_id` · `person_id` · `date_joined` · `is_active` |
| `stores` | `store_id` · `name` · `city` · `opened_on` |
| `employees` | `employee_id` · `person_id` · `store_id` · `supervisor_id` · `role` · `hired_on` |
| `categories` | `category_id` · `name` |
| `products` | `product_id` · `category_id` · `name` · `sku` · `unit_price` · `is_active` |
| `orders` | `order_id` · `customer_id` · `store_id` · `order_date` · `status` |
| `order_items` | `order_item_id` · `order_id` · `product_id` · `quantity` · `unit_price` |
| `payments` | `payment_id` · `order_id` · `paid_at` · `amount` · `method` |

Notes: the price column is `products.unit_price` (there is no `products.price`); names live in `persons`
(`customers` has no name columns); `orders.status` is an `ENUM('pending','paid','shipped','cancelled')`.

### Deterministic seed

| Table | Rows |
|---|---|
| `persons` | 12 |
| `addresses` | 12 |
| `customers` | 6 |
| `stores` | 2 |
| `employees` | 5 |
| `categories` | 4 |
| `products` | 10 |
| `orders` | 8 |
| `order_items` | 14 |
| `payments` | 6 |

The gate asserts these counts, so examples are reproducible.

### Provenance

`shopdb` is **original work**: the schema is designed for this course, and the seed is generated from the
owner's own synthetic CSVs in `data/dummy_data/`.

## Practice datasets (optional)

These larger, well-known sample databases are used for a few practice exercises. They are **fetched**, not
vendored — never committed to the repository.

| Dataset | Used by | Provenance |
|---|---|---|
| **Sakila** | practice (joins, routines) | Oracle/MySQL sample database (new BSD licence) |
| **Employees** (`test_db`) | practice (large-data tuning) | `datacharmer/test_db` (source data: Wang & Zaniolo, Siemens) |

```bash
python dbctl.py fetch        # downloads the practice datasets (uses the local archive if offline)
```

Credits are recorded in [NOTICE.md](../NOTICE.md).

## See also

- [GETTING_STARTED.md](GETTING_STARTED.md) — create and seed the database
- [FILE_CATALOG.md](FILE_CATALOG.md) — where the schema and seed files live
- [GLOSSARY.md](GLOSSARY.md) — the vocabulary used above
