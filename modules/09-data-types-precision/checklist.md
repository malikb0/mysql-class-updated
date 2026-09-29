# Module 09 — Data Types & Precision · Checklist

Try every item before committing — the module's gotchas are the kind of bugs that cost hours later.

- [ ] I can read a column's declared type from `information_schema.COLUMNS` *(notes: The concept)*
- [ ] I know why `DECIMAL(10,2)` is exact and `FLOAT`/`DOUBLE` is approximate — even for money *(notes: Worked example, Steps 1–2)*
- [ ] I can pick the right type for money (`DECIMAL`), IDs (`BIGINT`), short codes (`CHAR(n)`) and free text (`VARCHAR` / `TEXT`) *(assets/type-selection.md)*
- [ ] I distinguish `CHAR_LENGTH` (character count) from `LENGTH` (byte length) — especially with UTF-8 strings like café *(notes: Worked example, Step 6)*
- [ ] I understand why `ENUM` is a first-class type and how `JSON` lets me store flexible documents *(notes: Worked example, Steps 8 & 10)*
- [ ] I can spot an `UNSIGNED` surprise (`CAST(-1 AS UNSIGNED)` → huge positive) or an out-of-range error before they bite *(notes: Common errors & fixes)*

> 🧪 **Try it:** run the worked example from `examples/01-data-types-precision.sql`, then modify one query to intentionally trigger a gotcha. Notice how MySQL's error message tells you exactly what went wrong — that's your ally, not enemy.
