# Module 13 — Transactions & Concurrency · Checklist

Test every item below before moving into the next chapter — a working transaction is your safety net when you start writing multi-step operations.

- [ ] I can explain what ACID means (atomicity, consistency, isolation, durability) and why each property matters in real-world applications *(notes: §1 Why transactions matter)*
- [ ] I can open a transaction with `BEGIN`, then end it cleanly with either `COMMIT` or `ROLLBACK` *(notes: Worked example, Steps 3–4)*
- [ ] I can mark a savepoint inside a transaction and roll back just that portion without touching the whole thing *(notes: Worked example, Step 5)*
- [ ] I can read my session's current isolation level (`SELECT @@transaction_isolation`) and change it for this session only *(notes: Worked example, Step 6)*
- [ ] I can lock a row so another session cannot modify it until mine finishes — using `SELECT ... FOR UPDATE` *(notes: Worked example, Step 7)*
- [ ] I can explain why an `AUTO_INCREMENT` gap remains even after rolling back a transaction (the id itself is not part of the undo stack) *(notes: Worked example, Step 5)*

> 🧪 **Try it:** run the worked example, then roll back a transaction of your own and confirm the row is gone.