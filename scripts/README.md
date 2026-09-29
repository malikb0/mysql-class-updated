# Scripts

Helper scripts used to build and maintain the course. These are development tools, not part of the
learner-facing content.

| Script | Purpose |
|---|---|
| [legacy_to_md.py](legacy_to_md.py) | Converts the original UTF-16 class transcripts into sanitised, UTF-8 Markdown under `docs/reference/legacy/` (normalises line endings, removes machine-specific paths, converts ASCII result boxes to Markdown tables) |

Run it with Python 3:

```bash
python scripts/legacy_to_md.py --help
```

The generated transcripts are kept for provenance — see [docs/reference/legacy/](../docs/reference/legacy/).
