# Study guide

How to get the most out of the course.

## The shape of every module

Each module teaches one topic and always has the same parts, so you never have to guess where to look:

1. **`README.md`** — what the module is for and how to run it.
2. **`notes.md`** — the concepts, a vocabulary list, and a worked example with **real** output.
3. **`examples/01-*.sql`** — run it yourself (it is net-neutral, so it is safe to re-run).
4. **`exercises/README.md`** — four tasks, each with a goal, a hint and a way to verify.
5. **`solutions/01-exercises.sql`** — the answers (try first!).
6. **`checklist.md`** — six "I can…" items; you have understood the module when you can tick them all.

## A rhythm that works

1. **Read the notes** without running anything — get the idea.
2. **Run the example**, then change one thing and run it again. Watching output change is how the concept
   sticks.
3. **Do the exercises** before looking at the solutions.
4. **Run the checklist** out loud, or explain each item to someone (or your rubber duck).
5. **Move on** only when the checklist feels easy.

> 💡 **Aha:** the fastest learners re-type the example SQL by hand rather than copy-pasting it.

## Routes

- **Fast track (a weekend):** 00 → 01 → 02 → 03 → 05 → 06.
- **Interview prep:** 03 → 05 → 06 → 07 → 11 → 16.
- **Backend / ops:** 01 → 11 → 12 → 13 → 15 → 17 → 18 → 19.
- **Full course:** 00 → 21 in order, roughly two hours each plus exercises.

The full list with levels and prerequisites is in [SYLLABUS.md](../SYLLABUS.md); pacing notes are in
[LEARNING_PATH.md](../LEARNING_PATH.md).

## Habits worth building early

- **Always run a query `EXPLAIN`-first when it feels slow** — measure, don't guess (module 16).
- **Wrap exploration in `DROP TABLE IF EXISTS`** so re-runs are safe and the database stays net-neutral.
- **Write SQL multi-line**, one clause per line — it is easier to read and to debug.
- **Never build SQL by string-joining user input** — bind parameters instead (module 20).
- **Keep a scratch script** for the commands you repeat; the notes show the ones worth keeping.

## When you get stuck

1. Read the **common errors** table in the module's `notes.md` — most mistakes are listed with a fix.
2. Run `python dbctl.py reset` to get back to a clean, seeded `shopdb`.
3. Re-read the worked example; the answer to an exercise is usually one small variation of it.

## Where to next

- [GLOSSARY.md](GLOSSARY.md) — quick definitions of every term
- [DATASETS.md](DATASETS.md) — the database you are querying
- [STRUCTURE.md](STRUCTURE.md) — how the repository is laid out
