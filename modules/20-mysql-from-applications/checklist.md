# Module 20 — MySQL from Applications · Checklist

Test each item before moving on.

- [ ] I can explain how an application connects to MySQL and why a connection pool matters *(notes: §1 Why the app talks to the database)*
- [ ] I can tell a bound parameter from string splicing, and say why binding prevents SQL injection *(notes: §2 The concept)*
- [ ] I can read a connection's identity and the server's connection limits *(notes: Worked example, Steps 1–2)*
- [ ] I can use server-side prepared statements with `PREPARE`/`EXECUTE` and release them *(notes: Worked example, Steps 3–5)*
- [ ] I can run the example Python app and see it read and write `shopdb` safely *(notes: §4 How it works)*
- [ ] I can explain why the app connects as the least-privilege `shop` account *(notes: §7 Going deeper)*

> 🧪 **Try it:** change the app's category parameter, run it again, and confirm the output changes while `shopdb` still has 10 tables.
