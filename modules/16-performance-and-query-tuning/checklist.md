# Module 16 — Performance & Query Tuning · Checklist

Before moving on, make sure you can do each of the things below. If a bullet feels out of reach, come back to your query and ask whether the plan is telling you where MySQL is doing its work.

- [ ] I can explain why a full table scan gets slower as a table grows, and why an index helps *(notes: §1 Why a slow query deserves a plan)*
- [ ] I can read an `EXPLAIN` plan and tell a full scan from an index lookup *(notes: Worked example, Steps 2–5)*
- [ ] I can spot a function wrapped around an indexed column and rewrite the filter as a range *(notes: Worked example, Step 13)*
- [ ] I can recognise the N+1 shape and replace a correlated subquery with one join *(notes: Worked example, Step 14)*
- [ ] I can explain how cardinality and statistics decide whether the optimizer uses an index *(notes: §4 How it works)*
- [ ] I can name the `EXPLAIN` `type` values and say what each one means *(notes: §2 Reading a query plan with EXPLAIN)*

> 🧪 **Try it:** take a slow query of your own, run `EXPLAIN` before and after adding one index.
