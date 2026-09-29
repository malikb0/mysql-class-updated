"""Module 20 — MySQL from an application: connect, query and write safely.

Run:
    python3 modules/20-mysql-from-applications/app/query_shop.py

Connection details come from the environment (with local defaults), so the same
script works on your machine and against the Docker container:
    DB_HOST (default 127.0.0.1) · DB_PORT (default 3310)
    DB_USER (default shop)      · DB_PASSWORD (default shop)
    DB_NAME (default shopdb)
"""
from __future__ import annotations

import os

from sqlalchemy import create_engine, text

DB_HOST = os.environ.get("DB_HOST", "127.0.0.1")
DB_PORT = os.environ.get("DB_PORT", "3310")
DB_USER = os.environ.get("DB_USER", "shop")
DB_PASSWORD = os.environ.get("DB_PASSWORD", "shop")
DB_NAME = os.environ.get("DB_NAME", "shopdb")

URL = f"mysql+pymysql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}"


def main() -> None:
    # A pooled engine — connections are reused instead of opened per query.
    engine = create_engine(URL, pool_size=5, max_overflow=2, pool_pre_ping=True)

    with engine.begin() as conn:
        # 1. A parameterized read: the value is bound, never spliced into the SQL string.
        rows = conn.execute(
            text(
                "SELECT product_id, name, unit_price "
                "FROM products WHERE category_id = :cat ORDER BY product_id"
            ),
            {"cat": 1},
        ).all()
        print("category 1 products:")
        for product_id, name, unit_price in rows:
            print(f"  {product_id}  {name}  {unit_price}")

        # 2. A safe write to a throwaway table, parameterized the same way.
        conn.execute(text("DROP TABLE IF EXISTS practice_app_demo"))
        conn.execute(
            text(
                "CREATE TABLE practice_app_demo ("
                "  demo_id INT AUTO_INCREMENT PRIMARY KEY,"
                "  label VARCHAR(40) NOT NULL,"
                "  qty INT NOT NULL"
                ") ENGINE = InnoDB"
            )
        )
        conn.execute(
            text("INSERT INTO practice_app_demo (label, qty) VALUES (:label, :qty)"),
            [
                {"label": "Espresso Blend", "qty": 3},
                {"label": "Croissant", "qty": 2},
            ],
        )
        total = conn.execute(text("SELECT COUNT(*) FROM practice_app_demo")).scalar_one()
        print(f"practice_app_demo rows: {total}")

        # 3. Clean up so the database is exactly as you found it.
        conn.execute(text("DROP TABLE practice_app_demo"))

    with engine.connect() as conn:
        tables = conn.execute(
            text(
                "SELECT COUNT(*) FROM information_schema.tables "
                "WHERE table_schema = :db"
            ),
            {"db": DB_NAME},
        ).scalar_one()
    print(f"shopdb tables: {tables}")
    engine.dispose()


if __name__ == "__main__":
    main()
