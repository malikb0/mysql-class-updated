# Module 03 — Querying: SELECT, Filter, Sort · Checklist

Tick a box only when you can do it **without looking**. If you can't, revisit the linked section.

- [ ] I can write `SELECT` with only the columns I need — not `*`. *(notes §2)*
- [ ] I can filter rows with `WHERE` using a comparison (`>`, `<`, `=`, `<>`). *(notes §4)*
- [ ] I can combine conditions with `AND` and `OR`, including parentheses for precedence. *(notes §4)*
- [ ] I can use `LIKE`, `IN (...)`, and `BETWEEN ... AND ...` to filter without listing every value. *(notes §4)*
- [ ] I can check for nulls with `IS NULL` — and I know why `= NULL` returns zero rows instead of all of them. *(notes §5)*
- [ ] I can sort results with `ORDER BY` on one key or multiple keys (ASC / DESC). *(notes §2)*
- [ ] I can trim output with `LIMIT` and de-duplicate with `DISTINCT`. *(notes §4)*
- [ ] I can state the clause evaluation order: FROM → WHERE → SELECT → ORDER BY → LIMIT. *(notes §4)*
- [ ] I finished the tasks in `exercises/` and compared my answers with `solutions/`.

> 🧪 Try it: redo Step 2 from a blank `shopdb` without notes — list premium items over $10, most expensive first. If you get stuck, that box isn't ticked yet — that's the signal to go back, not a failure.