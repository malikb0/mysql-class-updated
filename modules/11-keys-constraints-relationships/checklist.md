# Module 11 — Keys, Constraints & Relationships · Checklist

Before moving to the next module, make sure you can do every item below without looking at a cheat sheet. If you've worked through the exercises and solutions, these should be second nature.

- [ ] **Pick the right key or constraint.** *(notes → The concept)* — when is `UNIQUE` enough versus when you need `PRIMARY KEY`; how to add `NOT NULL`, `DEFAULT`, and `CHECK`.
- [ ] **Explain `UNIQUE` vs `PRIMARY KEY`.** *(notes → The concept)* — a primary key does two things (unique + not null); a unique constraint only does one. Why both exist: some systems let you change the primary key, but every unique column stays unique no matter what happens.
- [ ] **Choose an `ON DELETE` / `ON UPDATE` action.** *(notes → The concept)* — know the three options (`CASCADE`, `RESTRICT`, `SET NULL`) and why `NO ACTION` (the InnoDB default) is often the safest choice for production data.
- [ ] **Read constraints from `information_schema`.** *(notes → Steps 4–6, 8)* — use `table_constraints`, `key_column_usage`, and `referential_constraints` to see what a database enforces before you write code that depends on it.
- [ ] **Recognise a constraint violation from its error.** *(notes → Common errors & fixes)* — the four most common errors (duplicate entry, foreign key fail, check violated, column cannot be null) each tell you exactly which constraint was broken and why.
- [ ] **Keep scripts net-neutral.** *(notes → Step 9)* — every script that creates practice tables should end with `DROP TABLE` statements so running it twice doesn't leave stale state behind.

> 🧪 Try it: open a fresh terminal, connect to MySQL, pick any two tables in `shopdb`, and write a one-line query against `information_schema.referential_constraints` to see every foreign key that ships with the seed data. If you can read that view fluently you've mastered this module's hardest part.
