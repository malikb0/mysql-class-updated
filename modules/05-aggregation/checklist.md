# Module 05 — Aggregation & Grouping · Checklist

Tick a box only when you can do it **without looking**. If you can't, revisit the linked section.

- [ ] I can explain what an aggregate function does in one sentence: it collapses many values into one number (count, sum, average, min, or max). *(notes §2)*
- [ ] I can write `COUNT(*)`, `SUM(col)`, `AVG(col)`, `MIN(col)`, and `MAX(col)` from memory. *(notes §3)*
- [ ] I can group rows with `GROUP BY` — every unique value of the grouping key becomes one output row. *(notes §2)*
- [ ] I can state the clause order for aggregation: FROM → WHERE → GROUP BY → HAVING → SELECT → ORDER BY. *(notes §4)*
- [ ] I know why `WHERE` filters rows before grouping and `HAVING` filters groups after — they are not interchangeable. *(notes §4)*
- [ ] I can explain why `COUNT(*)` counts every row while `COUNT(supervisor_id)` skips the one with a NULL supervisor. *(notes §3, §4)*
- [ ] I finished the tasks in `exercises/` and compared my answers with `solutions/`.

> 🧪 Try it: redo Step 7 from a blank `shopdb` without notes — fetch the product name and price of the most expensive item using an aggregate subquery. If you get stuck, that box isn't ticked yet — that's the signal to go back, not a failure.
