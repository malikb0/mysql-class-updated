# Module 12 — Indexes & Views · Checklist

Reading a query plan before writing SQL is the skill that separates guessing from knowing.

- [ ] I can read a table's indexes from `information_schema.statistics` *(notes: Worked example, Step 1)*
- [ ] I can read an `EXPLAIN` plan and tell `type = ALL` from `type = ref` / `const` *(notes: Worked example, Steps 2–4)*
- [ ] I can add an index and see the optimizer switch to it *(notes: Worked example, Step 5)*
- [ ] I can explain a covering index (`Extra` shows `Using index`) *(notes: Worked example, Step 8)*
- [ ] I can create, replace, query and drop a view *(notes: Worked example, Steps 10–13)*
- [ ] The foreign-key gotcha — an index needed by a foreign key cannot be dropped (`ERROR 1553`) *(notes: §5 Common errors & fixes)*

> 🧪 **Try it:** run the worked example, then `EXPLAIN` a query filtering `orders.status` before and after you add an index, and watch `type` change from `ALL` to `ref`.
