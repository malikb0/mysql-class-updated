# Module 18 — Server Administration & Operations · Checklist

Test every item below on your own machine before moving into the next module. If you cannot get it working, re-read the worked example and try again.

- [ ] I can explain why a running server needs a caretaker, not just queries *(notes: §1 Why the server needs a caretaker)*
- [ ] I can read the configuration the server is running with, including `max_connections` and the buffer pool *(notes: Worked example, Step 3)*
- [ ] I can list live sessions and status counters *(notes: Worked example, Steps 4–5)*
- [ ] I can turn the slow-query log on and off, and explain why `SET GLOBAL` does not change the current session *(notes: Worked example, Steps 6–11)*
- [ ] I can run routine maintenance with `ANALYZE`, `CHECK` and `OPTIMIZE` *(notes: Worked example, Steps 13–15)*
- [ ] I can tell the storage engines apart and say why InnoDB is the default *(notes: §7 Going deeper)*

> 🧪 **Try it:** set `long_query_time` to 0, run a few queries, then read the slow log and put the setting back.

[Back to course index](../../SYLLABUS.md)