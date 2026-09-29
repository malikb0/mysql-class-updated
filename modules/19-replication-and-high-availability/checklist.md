# Module 19 — Replication & High Availability · Checklist

Before moving on, make sure you can explain or demonstrate each of these items using your own machine — not a written script. If any item is unclear, reread the relevant section in `notes.md` until it makes sense.

- [ ] I can **explain why one server is a single point of failure** and describe what happens when the primary falls over — including how a replica keeps you at least partially available. *(notes: §1 Why one server is a single point of failure)*
- [ ] I can **describe what the binary log sends from a primary to a replica**: row-level change events, GTID transaction ids, and relay logs on the secondary side. *(notes: §2 The concept — primary, replica and the binary log)*
- [ ] I can **read this server's replication posture and its binlog coordinates** in one query, understand why GTID is off on a single-server installation, and explain why `sync_binlog` is turned on by default. *(notes: Worked example, Steps 1–3)*
- [ ] I can **check whether a server is a replica or has replicas of its own** using `SHOW REPLICA STATUS` (empty means not a replica) versus `SHOW REPLICAS` (empty means nobody has joined yet). *(notes: Worked example, Steps 4–5)*
- [ ] I can **stand up a real replica and show a change copying across**: create the account, take a snapshot with binlog coordinates, start a second MySQL container as a replica, point it at the primary, insert a row on the primary and read it back on the replica. *(notes: §4 How it works — the real replication drill)*
- [ ] I can **explain GTID (a transaction id that replaces fragile file-and-position pairs), async vs semi-sync replication, and the basics of failover** (stop replication on a replica + clear `read_only` to accept writes). *(notes: §7 Going deeper)*

> 🧪 **Try it:** start a second MySQL container as a replica, point it at the primary, and watch an `INSERT` appear on it. The change copies across in seconds — often milliseconds — which is what makes this module worth learning instead of accepting "production always works" myths.