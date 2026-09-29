# Module 17 — Backup & Recovery · Checklist

Before moving on, go through each item in the checklist below. Test it yourself so you can trust what you've learned.

- [ ] I can explain why a backup is the café's insurance against a bad `DELETE` *(notes: §1 Why backups are the café's insurance)*
- [ ] I can tell a logical backup from a physical backup and say when to use each *(notes: §2 The concept)*
- [ ] I can read the binary-log state with `SHOW BINARY LOG STATUS` and `SHOW BINARY LOGS` *(notes: Worked example, Steps 2–3)*
- [ ] I can show what a dump stores for a table *(notes: Worked example, Step 4)*
- [ ] I can run a real backup and restore drill *(notes: §4 How it works)*
- [ ] I can explain how the binary log enables point-in-time recovery *(notes: §7 Going deeper)*

> 🧪 **Try it:** back up `shopdb` with `mysqldump`, delete a few rows, then restore the dump and confirm the counts.