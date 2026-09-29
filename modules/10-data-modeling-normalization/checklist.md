# Module 10 — Data Modeling & Normalization · Checklist

- [ ] I can name the **entity** and **relationship** in a schema *(notes → The concept)*
- [ ] I can spot a **repeating group** in a flat table *(notes → Step 3)*
- [ ] I can explain why a dependency is **partial** vs **transitive** *(notes → 2NF / 3NF)*
- [ ] I can walk a table **1NF → 2NF → 3NF** and rebuild the original picture with a join *(notes → Worked example)*
- [ ] I can say when **denormalization** pays — and name the trade-off *(notes → When to denormalize)*
- [ ] I can read a schema's relationships straight from `information_schema.key_column_usage` *(notes → Step 2)*

> 🧪 Try it: pick any table in `shopdb` and ask yourself which columns depend on which keys. If you find a transitive dependency, that's your 3NF fix waiting to happen.
