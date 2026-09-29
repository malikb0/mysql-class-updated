# Stored programs at a glance

Stored programs save SQL logic inside the database so several applications can share one set of rules — like having a recipe on your phone instead of writing it out every time you visit a store. This page is a memory aid for remembering which program to reach for; the worked example is in [`../notes.md`](../notes.md).

> 💡 Aha: once a procedure lives inside the database, any app — POS system, mobile checkout, admin dashboard — can call it and get consistent results without duplicating logic.

The diagram above shows how four kinds of stored programs live inside `shopdb`. They do not talk to each other directly; they all send work to the server, and the server runs them one at a time in its own thread pool. A procedure or function is called explicitly by an application or query; a trigger fires automatically whenever you INSERT, UPDATE, or DELETE on the table it watches; an event is scheduled ahead of time (the scheduler must be running).

## The four kinds

| Kind | Runs when | You use it with | Gives back |
|---|---|---|---|
| Stored procedure | you ask it to | `CALL name(...)` | a result set, or nothing |
| Stored function | inside a query | `SELECT name(...)` | exactly one value |
| Trigger | a table changes | automatic on `INSERT`, `UPDATE`, `DELETE` | nothing |
| Event | on a schedule | automatic (the scheduler must be on) | nothing |

## When a program runs

You **call** procedures with `CALL proc_name(args)` and invoke functions anywhere inside a query — `SELECT fn(a, b) FROM orders WHERE ...`. The server takes your request, looks for the saved body in the database, and executes it. Triggers have no invocation step: they are attached to table events (`BEFORE INSERT`, `AFTER UPDATE`, etc.) and fire every time that event fires on the watched table — but only if you define them inside `shopdb`. The scheduler (started with `--start-scheduler` or via `INNOVO_SCHEDULER_START=1`) runs scheduled jobs; the server checks each hour for expired cron entries, then enqueues and executes them.

## Creating one needs a delimiter

MySQL reads statements by looking for its own statement terminator — a semicolon (`;`). A stored procedure's body contains many semicolons inside it, so you need to tell MySQL where the *procedure definition* ends before each of those internal ones is interpreted as a new command. You do this with `DELIMITER`:

```sql
DELIMITER ;  -- back to the normal terminator (the default)
DELIMITER $$ -- switch for now so the body can contain ; without confusing the parser
CREATE PROCEDURE update_product_price(pid INT, new_price DECIMAL(10,2))
BEGIN
    UPDATE products SET unit_price = new_price WHERE product_id = pid;
END;
$$  -- now MySQL sees the $$ and knows the procedure is complete
DELIMITER ;  -- switch back so subsequent statements use the normal semicolon again
```

Every stored program (procedure, function, trigger, or event) needs a delimiter change if its body has multiple statements. A one-liner does not — you can `CREATE PROCEDURE noop() SELECT 'ok';` without any delimiter at all.

Next: the worked example is in [`../notes.md`](../notes.md); the full course list is in
[`../../../SYLLABUS.md`](../../../SYLLABUS.md).