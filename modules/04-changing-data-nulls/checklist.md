# Module 04 — Changing Data & Nulls · Checklist

Tick a box only when you can do it **without looking**. If you can't, revisit the linked section.

- [ ] I can write an `UPDATE` with a correct `WHERE` clause that changes exactly the rows I want. *(notes §3)*
- [ ] I can remove a row with `DELETE … WHERE …` and explain why a bare `UPDATE table SET col = val;` (no WHERE) hits every row. *(notes §4)*
- [ ] I can explain why `= NULL` matches zero rows while `IS NULL` does the opposite — because **NULL means "unknown"**, not equal to anything. *(notes §3, §5)*
- [ ] I can predict that any comparison involving a NULL evaluates to **UNKNOWN** (which acts like FALSE in WHERE). *(notes §4)*
- [ ] I can use `COALESCE(column, fallback)` to give a NULL a safe default for display. *(notes §3, §4)*
- [ ] I can wrap an experiment write in `START TRANSACTION … ROLLBACK` so it's reversible. *(notes §4)*
- [ ] I finished the tasks in `exercises/` and compared my answers with `solutions/`.

> 🧪 Try it: redo Step 1 from a blank `shopdb` without notes — increase the price of one product by $0.50 using exactly that row's primary key. If you get stuck, that box isn't ticked yet — that's the signal to go back, not a failure.