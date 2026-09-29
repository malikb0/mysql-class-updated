#!/usr/bin/env python3
"""shopdb control CLI — one entry point for Windows, macOS and Linux.

Only the Python standard library is used; Docker (Compose) runs MySQL, so no
local database client is required. Run `python dbctl.py --help` for commands.
"""
from __future__ import annotations

import argparse
import os
import shutil
import subprocess
import sys
import time
from pathlib import Path

ROOT = Path(__file__).resolve().parent
ENV_FILE = ROOT / ".env"
ENV_EXAMPLE = ROOT / ".env.example"
SQL_SETUP = ROOT / "sql" / "setup"
DATA_DIR = ROOT / "data"
ARCHIVE_HINT = "data/sakila/ and data/employees/ (or set MYSQL_CLASS_ARCHIVE)"


def read_env() -> dict[str, str]:
    """Merge .env/.env.example values, letting real environment variables win."""
    values: dict[str, str] = {}
    for path in (ENV_EXAMPLE, ENV_FILE):
        if not path.exists():
            continue
        for raw in path.read_text(encoding="utf-8").splitlines():
            line = raw.strip()
            if not line or line.startswith("#") or "=" not in line:
                continue
            key, val = line.split("=", 1)
            values[key.strip()] = val.strip()
    for key, val in os.environ.items():
        if key.startswith("MYSQL_"):
            values[key] = val
    return values


def _run(cmd: list[str], *, input_text: str | None = None, check: bool = True) -> int:
    try:
        proc = subprocess.run(cmd, cwd=ROOT, text=True, input=input_text, check=False)
    except FileNotFoundError:
        sys.exit(f"command not found: {cmd[0]} — is Docker installed and on PATH?")
    if check and proc.returncode != 0:
        sys.exit(f"command failed ({proc.returncode}): {' '.join(cmd)}")
    return proc.returncode


def _compose(*args: str, input_text: str | None = None, check: bool = True) -> int:
    return _run(["docker", "compose", *args], input_text=input_text, check=check)


def _mysql(sql: str, *, database: str | None = None, root: bool = False, check: bool = True) -> int:
    env = read_env()
    if root:
        user, pwd = "root", env.get("MYSQL_ROOT_PASSWORD", "root")
    else:
        user, pwd = env.get("MYSQL_USER", "shop"), env.get("MYSQL_PASSWORD", "shop")
    args = ["exec", "-T", "mysql", "mysql", f"-u{user}", f"-p{pwd}"]
    if database is None:
        database = env.get("MYSQL_DATABASE", "shopdb")
    if database:
        args.append(database)
    return _compose(*args, input_text=sql, check=check)


def _run_as_root(text: str) -> bool:
    """A .sql file may start with `-- run-as: root` to request the admin account.

    Needed for account/privilege files (CREATE USER / GRANT), which the non-SUPER
    app user cannot execute.
    """
    for line in text.splitlines():
        stripped = line.strip()
        if not stripped:
            continue
        if stripped.lower().startswith("-- run-as:"):
            return stripped.split(":", 1)[1].strip().lower() == "root"
        return False
    return False


def cmd_setup(_: argparse.Namespace) -> None:
    if not ENV_FILE.exists():
        ENV_FILE.write_text(ENV_EXAMPLE.read_text(encoding="utf-8"), encoding="utf-8")
        print("created .env from .env.example")
    else:
        print(".env already present")
    _compose("pull", "mysql", check=False)
    print("setup complete — next: python dbctl.py up")


def _wait_for_mysql(timeout: int = 90) -> None:
    env = read_env()
    root_pwd = env.get("MYSQL_ROOT_PASSWORD", "root")
    deadline = time.time() + timeout
    while time.time() < deadline:
        code = _compose(
            "exec", "-T", "mysql", "mysqladmin", "ping", "-h127.0.0.1",
            "-uroot", f"-p{root_pwd}", "--silent", check=False,
        )
        if code == 0:
            return
        time.sleep(2)
    sys.exit("MySQL did not become ready in time — check `docker compose logs mysql`")


def cmd_up(_: argparse.Namespace) -> None:
    _compose("up", "-d")
    _wait_for_mysql()
    print("MySQL is up on port " + read_env().get("MYSQL_PORT", "3306"))


def cmd_down(_: argparse.Namespace) -> None:
    _compose("down")
    print("MySQL stopped")


def cmd_seed(_: argparse.Namespace) -> None:
    files = sorted(SQL_SETUP.glob("*.sql"))
    if not files:
        sys.exit("no sql/setup/*.sql files found")
    for path in files:
        label = path.relative_to(ROOT)
        print(f"applying {label}")
        _mysql(path.read_text(encoding="utf-8"))
    print("seeded shopdb")


def cmd_reset(_: argparse.Namespace) -> None:
    _compose("down", "-v")
    cmd_up(argparse.Namespace())
    cmd_seed(argparse.Namespace())


def cmd_sql(args: argparse.Namespace) -> None:
    if args.file:
        text = Path(args.file).read_text(encoding="utf-8")
    elif args.sql:
        text = args.sql
    else:
        sys.exit("provide --file PATH or --sql \"SELECT ...\"")
    _mysql(text, database=args.database, check=True, root=_run_as_root(text))


def cmd_fetch(_: argparse.Namespace) -> None:
    import urllib.request
    import zipfile

    sources = {
        "sakila": "https://downloads.mysql.com/docs/sakila-db.zip",
        "employees": "https://github.com/datacharmer/test_db/archive/refs/heads/master.zip",
    }
    archive = read_env().get("MYSQL_CLASS_ARCHIVE", "")
    for name, url in sources.items():
        dest = DATA_DIR / name
        if dest.exists() and any(dest.iterdir()):
            print(f"{name}: already present — skipping")
            continue
        dest.mkdir(parents=True, exist_ok=True)
        try:
            print(f"{name}: downloading {url}")
            with urllib.request.urlopen(url, timeout=60) as resp:
                payload = resp.read()
            zip_path = dest / f"{name}.zip"
            zip_path.write_bytes(payload)
            with zipfile.ZipFile(zip_path) as zf:
                zf.extractall(dest)
            zip_path.unlink()
            print(f"{name}: extracted to {dest.relative_to(ROOT)}")
        except Exception as exc:  # noqa: BLE001 - offline is an expected case
            print(f"{name}: download unavailable ({exc})")
            copied = _fetch_from_archive(archive, name, dest)
            if not copied:
                print(f"{name}: skipped — no download and no archive ({ARCHIVE_HINT})")


def _fetch_from_archive(archive: str, name: str, dest: Path) -> bool:
    if not archive:
        return False
    base = Path(archive).expanduser()
    candidate = base / ("sakila-db" if name == "sakila" else "test_db")
    if not candidate.exists():
        return False
    for item in candidate.iterdir():
        if item.is_file():
            shutil.copy2(item, dest / item.name)
    print(f"{name}: copied from archive {candidate}")
    return True


def cmd_test(_: argparse.Namespace) -> None:
    tests = ROOT / "tests"
    if not tests.exists():
        print("no tests/ directory yet — nothing to run")
        return
    _run([sys.executable, "-m", "pytest", "-q", "tests"], check=False)


def cmd_verify(_: argparse.Namespace) -> None:
    gate = ROOT / ".orchestrator" / "scripts" / "verify-readiness.sh"
    if gate.exists() and shutil.which("bash"):
        _run(["bash", str(gate)], check=False)
    else:
        print("gate not available (bash or .orchestrator gate missing)")


def cmd_examples(_: argparse.Namespace) -> None:
    """Run every modules/**/*.sql against the seeded shopdb — the content↔infra check."""
    roots = [p for p in (ROOT / "modules",) if p.exists()]
    files = sorted(path for root in roots for path in root.rglob("*.sql"))
    if not files:
        print("no module .sql files found — nothing to run")
        return
    passed, failed = 0, 0
    for path in files:
        text = path.read_text(encoding="utf-8")
        code = _mysql(text, check=False, root=_run_as_root(text))
        if code == 0:
            passed += 1
            print(f"PASS {path.relative_to(ROOT)}")
        else:
            failed += 1
            print(f"FAIL {path.relative_to(ROOT)}")
    print(f"\n{passed} passed, {failed} failed")
    if failed:
        sys.exit(1)


def cmd_docs(_: argparse.Namespace) -> None:
    if not (ROOT / "mkdocs.yml").exists():
        print("MkDocs is optional and not configured — skipping")
        return
    _run([sys.executable, "-m", "mkdocs", "build"], check=False)


def main() -> None:
    parser = argparse.ArgumentParser(prog="dbctl", description="shopdb control CLI")
    sub = parser.add_subparsers(dest="command", required=True)
    for name, help_text, func in [
        ("setup", "create .env and pull the MySQL image", cmd_setup),
        ("up", "start MySQL (docker compose up -d)", cmd_up),
        ("down", "stop MySQL", cmd_down),
        ("seed", "apply sql/setup/*.sql to shopdb", cmd_seed),
        ("reset", "recreate the database volume and seed", cmd_reset),
        ("fetch", "download the practice datasets", cmd_fetch),
        ("test", "run the test suite", cmd_test),
        ("verify", "run the readiness gate", cmd_verify),
        ("examples", "run every modules/**/*.sql against seeded shopdb", cmd_examples),
        ("docs", "build the optional MkDocs site", cmd_docs),
    ]:
        p = sub.add_parser(name, help=help_text)
        p.set_defaults(func=func)
    sql = sub.add_parser("sql", help="run SQL or a .sql file against shopdb")
    sql.add_argument("--file", default="")
    sql.add_argument("--sql", default="")
    sql.add_argument("--database", default=None)
    sql.set_defaults(func=cmd_sql)

    args = parser.parse_args()
    args.func(args)


if __name__ == "__main__":
    main()
