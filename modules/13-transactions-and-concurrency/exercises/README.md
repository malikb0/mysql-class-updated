# Module 13 — Transactions & Concurrency · Exercises

Each task: **goal → hint → verify**. Solutions live in `../solutions/` (try first!).

---

## Task 1 — Read the session's transaction defaults

**Goal:** What are the default values for your MySQL session? Find them. Run this query and you'll see two columns — one tells whether transactions autocommit, the other names your default isolation level.

> 🎯 Goal: `SELECT @@autocommit AS autocommit, @@transaction_isolation AS isolation_level;`

**Hint:** In a new session (outside any transaction), run that query. The defaults are what you want — they apply to every transaction you begin unless you change them.

**Verify:** 1 row — `autocommit = 1`, `isolation_level = REPEATABLE-READ`. This is the default, and it's a good starting point for understanding how transactions behave.

---

## Task 2 — Commit keeps a row

**Goal:** Create a tiny InnoDB table, start a transaction, insert one row, commit it, then check that the row stuck. This proves that `COMMIT;` is what makes changes permanent.

> 🎯 Goal:
> ```sql
> CREATE TABLE practice_tx_ex (
>   id    INT AUTO_INCREMENT PRIMARY KEY,
>   label VARCHAR(40) NOT NULL
> ) ENGINE = InnoDB;
> START TRANSACTION;
> INSERT INTO practice_tx_ex (label) VALUES ('committed');
> COMMIT;
> SELECT COUNT(*) AS after_commit FROM practice_tx_ex;
> ```

**Hint:** Use InnoDB — MyISAM doesn't support transactions. Name the table something that does **not** collide with the real `shopdb` tables (here, `practice_tx_ex`). After the `COMMIT`, your session can see the row, and so can any other session in this database.

**Verify:** `after_commit = 1`. The row survived because `COMMIT;` made it permanent.

---

## Task 3 — Rollback discards a row

**Goal:** Do the same setup but with `ROLLBACK;` instead of `COMMIT;`. The row you inserted should vanish. This is how undo works in SQL: every change lives in transactional memory until you commit it, and `ROLLBACK;` throws away everything from that transaction.

> 🎯 Goal:
> ```sql
> START TRANSACTION;
> INSERT INTO practice_tx_ex (label) VALUES ('rolled back');
> ROLLBACK;
> SELECT COUNT(*) AS after_rollback FROM practice_tx_ex;
> ```

**Hint:** Reuse the `practice_tx_ex` table from Task 2. Start a new transaction, insert one row, then `ROLLBACK;` — the row vanishes and nothing else changes. (DDL such as `CREATE TABLE` is not transactional in MySQL: it commits implicitly, so never wrap it in a rollback you expect to undo.)

**Verify:** `after_rollback = 1` — the committed row from Task 2 is still there, and your rolled-back insert never happened. Separate transactions do not affect each other.

---

## Task 4 — Savepoint keeps part of a transaction

**Goal:** Sometimes you want to undo only *part* of what you did inside a transaction. A savepoint marks a spot in the transaction where you can roll back to, leaving earlier work intact. Create two rows: one before and one after a savepoint, then rollback to that savepoint — the first row should survive.

> 🎯 Goal:
> ```sql
> START TRANSACTION;
> INSERT INTO practice_tx_ex (label) VALUES ('kept');
> SAVEPOINT sp1;
> INSERT INTO practice_tx_ex (label) VALUES ('discarded');
> ROLLBACK TO SAVEPOINT sp1;
> COMMIT;
> SELECT id, label FROM practice_tx_ex ORDER BY id;
> ```

**Hint:** The savepoint is a checkpoint inside the transaction. After `ROLLBACK TO SAVEPOINT sp1`, everything before `sp1` is preserved and everything after it is undone — then `COMMIT;` makes the surviving changes permanent across sessions. This pattern is common for partial-undo: "try this batch, keep me out of it if there's a problem."

**Verify:** The row labelled `kept` survives; the one labelled `discarded` does not. Savepoints let you carve out a safety zone within a transaction.

---

> 🧪 Try it yourself first — then peek at the solutions in `../solutions/` to see how they're done.

Each task should leave your database **net-neutral**: if you create a table, drop it when you're done; every change should be fully committed or fully rolled back so no one session sees partial state from another.