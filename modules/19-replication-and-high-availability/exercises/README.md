# Module 19 — Replication & High Availability · Exercises

Each task: **goal → hint → verify**. Solutions live in `../solutions/` (try first!).

---

## Task 1 — Read the replication posture

**Goal:** read this server's identity, logging and GTID settings in one row.
```sql
SELECT
  @@server_id     AS server_id,
  @@log_bin       AS binlog_on,
  @@binlog_format AS binlog_format,
  @@gtid_mode     AS gtid_mode,
  @@sync_binlog   AS sync_binlog;
```

**Hint:** `@@` reads a session variable. All these values are server-level defaults that never change across the course's instances — they are not questions about your machine.

> 🎯 **Goal:** read five settings in one query and explain what each means: why `binlog_format = ROW`, why GTID is off on a single-server installation, why `sync_binlog` is turned on (it ensures every log write reaches disk before the statement returns).

**Verify:** `server_id = 1`, `binlog_on = 1`, `binlog_format = ROW`, `gtid_mode = OFF`, `sync_binlog = 1`. Drop nothing — you only read.

---

## Task 2 — Read the current binary-log coordinates

**Goal:** find which file and position a replica would copy from right now.
```sql
SHOW BINARY LOG STATUS;
```

**Hint:** this command shows the active binlog file, its total size and exactly where in it you should start copying — but these values change every time you write to the primary. Treat them as read-only snapshots of your machine's current state.

> 🎯 **Goal:** understand why binary-log positions are fragile: if the log gets rotated or purged (which happens after 30 days by default) the file and position stop existing, causing error 1236 on every replica that tried to use them.

**Verify:** one row giving the current `File` and `Position` (both values change as the server writes, so they are not fixed). Drop nothing — you only read.

---

## Task 3 — Prove this server is neither a replica nor yet a source

**Goal:** show that no replication connections exist in any direction.
```sql
SHOW REPLICA STATUS;
```

> 🎯 **Goal:** understand the difference between these two commands: `SHOW REPLICA STATUS` asks "am I copying from someone?" (empty means you are not a replica), while `SHOW REPLICAS` asks "do I have any copies attached to me?" (empty means nobody has joined yet). Both return empty on this server and that is the expected starting state before building a replica in §4.

**Verify:** both `SHOW REPLICA STATUS` and `SHOW REPLICAS` return an empty result set. Drop nothing — you only read.

---

## Task 4 — Create the replication account a replica needs, then show its grants

**Goal:** create a user with exactly the two privileges that every MySQL replica requires.
```sql
SHOW GRANTS FOR 'replica'@'%';
```

**Hint:** `caching_sha2_password` is MySQL's default authentication plugin; the replica connects to the primary over TLS (`SOURCE_SSL=1`). The two privileges are non-negotiable: `REPLICATION SLAVE` (to request relay logs and GTID position updates) and `REPLICATION CLIENT` (to read replication state).

> 🎯 **Goal:** understand why these exact grants exist: without them the replica cannot start IO threads, cannot ask for log positions or GTID updates, and cannot see its own replication status. The same account is used on every replica in a real production environment — it lives as long as any replica might need to rejoin.

**Verify:** the grants include `REPLICATION SLAVE` and `REPLICATION CLIENT` on `*.*`; drop the account afterwards with `DROP USER IF EXISTS 'replica'@'%';`.

---

> 🧪 **Try it yourself first — then peek at the solutions in `../solutions/` to see how they're done.**

**Net-neutral reminder:** every task should leave the database in its original state (10 tables, no practice data or accounts left behind). Drop any table you create; drop any user you grant. If a task is read-only (Tasks 1–3) then nothing needs cleanup — those queries are side-free by design.