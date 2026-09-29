#!/usr/bin/env python3
"""Convert a legacy class transcript (raw SQL + pasted ASCII result tables) into a
GitHub-flavoured Markdown file, in place.

- Decodes UTF-8 or UTF-16LE, writes UTF-8 with LF.
- Adds an H1 title derived from the filename.
- Keeps SQL verbatim inside ```sql fences (never re-splits or rewrites statements).
- Converts every ASCII table (the phpMyAdmin `+---+` blocks) to a Markdown table.

Usage:
    python legacy_to_md.py PATH [PATH ...]
    python legacy_to_md.py --dry-run PATH
"""
from __future__ import annotations

import re
import sys
from pathlib import Path

BORDER = re.compile(r"^\s*\+[-=+]+\+\s*$")


def read_text(path: Path) -> str:
    raw = path.read_bytes()
    if raw[:2] in (b"\xff\xfe", b"\xfe\xff"):
        text = raw.decode("utf-16")
    else:
        try:
            text = raw.decode("utf-8")
        except UnicodeDecodeError:
            text = raw.decode("utf-16-le")
    return text.replace("\r\n", "\n").replace("\r", "\n")


def title_for(path: Path) -> str:
    stem = path.stem  # e.g. class-03 or class-01-02
    m = re.match(r"class-(\d{2}(?:-\d{2})?)", stem)
    return f"Class {m.group(1)}" if m else stem.replace("-", " ").title()


def split_cells(row: str) -> list[str]:
    return [c.strip() for c in row.strip().strip("|").split("|")]


def render_table(rows: list[list[str]]) -> str:
    header, *body = rows
    out = ["| " + " | ".join(header) + " |",
           "|" + "|".join("---" for _ in header) + "|"]
    for r in body:
        r = (r + [""] * len(header))[: len(header)]
        out.append("| " + " | ".join(r) + " |")
    return "\n".join(out)


def convert(text: str, title: str) -> str:
    lines = text.split("\n")
    out: list[str] = [f"# {title}", ""]
    i, n = 0, len(lines)

    def starts_table(idx: int) -> bool:
        line = lines[idx]
        if BORDER.match(line):
            return True
        # a header row immediately followed by a border (phpMyAdmin often omits the top border)
        return line.lstrip().startswith("|") and idx + 1 < n and bool(BORDER.match(lines[idx + 1]))

    while i < n:
        if starts_table(i):
            block: list[str] = []
            while i < n and (BORDER.match(lines[i]) or lines[i].lstrip().startswith("|")):
                block.append(lines[i])
                i += 1
            rows = [split_cells(l) for l in block if l.lstrip().startswith("|")]
            rows = [r for r in rows if any(c for c in r)]
            out += [render_table(rows), ""] if len(rows) >= 2 else ["<!-- output omitted -->", ""]
            continue
        run: list[str] = []
        while i < n and not starts_table(i):
            run.append(lines[i])
            i += 1
        body = "\n".join(run).strip("\n")
        if body.strip():
            out += ["```sql", body, "```", ""]
    return "\n".join(out).rstrip("\n") + "\n"


def main() -> None:
    args = [a for a in sys.argv[1:] if a != "--dry-run"]
    dry = "--dry-run" in sys.argv
    if not args:
        sys.exit("usage: legacy_to_md.py PATH [PATH ...]")
    for arg in args:
        path = Path(arg)
        if not path.is_file():
            print(f"skip (not a file): {path}")
            continue
        result = convert(read_text(path), title_for(path))
        if dry:
            print(f"--- {path} ---")
            print(result)
        else:
            path.write_text(result, encoding="utf-8", newline="\n")
            print(f"converted {path}")


if __name__ == "__main__":
    main()
