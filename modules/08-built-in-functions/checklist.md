# Module 08 — Built-in Functions · Checklist

Before moving to the next module, run through these six checks. Each one maps back to a section in `notes.md` so you can re-read the worked example if stuck.

- [ ] I can concatenate and clean text with `CONCAT`, `UPPER`/`LOWER`, `TRIM`, `REPLACE` *(notes §3)*
- [ ] I can slice strings with `LEFT` and `SUBSTRING_INDEX` — e.g. pulling the SKU number from `'COF-001'` *(notes §3)*
- [ ] I can round, floor, and ceiling numbers with `ROUND`, `FLOOR`, `CEIL` *(notes §4)*
- [ ] I can pull date parts (`DAYNAME`, `MONTHNAME`) and add/subtract intervals with `DATE_ADD`/`DATE_SUB` *(notes §6–7)*
- [ ] I can replace a missing value with `COALESCE` so that `CONCAT` doesn't produce `NULL` *(notes §9)*
- [ ] I can branch rows with `CASE` and summarise many rows into one with `GROUP_CONCAT` *(notes §10–12)*

> 🧪 Try it — pick any two items above, write a query on your own table (even one you create), and run it. If the output matches what you expect, you've mastered that function family. Move on to Module 09.