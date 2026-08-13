# CLAUDE.md

This is the entry point. Claude reads this file first on every task. Keep it short.
It does two jobs: (1) route to the right context files, (2) state the rules that are
never optional.

---

## How to work on this project

Before any task, read:
- `.ai/persona.md` — how to operate (seniority bar, when to stop, defaults)
- `.ai/operating-rules.md` — workflow and definition of done

For feature work, also read:
- the relevant spec in `specs/`
- `.ai/engineering/standards.md` — how code must be written
- `.ai/engineering/architecture.md` — system design and boundaries
- `.ai/engineering/patterns.md` — approved patterns and anti-patterns
- `.ai/client/glossary.md` — domain terms (read this to avoid misusing language)

When you make a non-trivial choice, record it in `docs/decisions-log.md`.
When something is blocked on a human decision, add it to `docs/open-questions.md`.

---

## Build / verify / ship workflow

For execution, use the installed agent-skills (see README for install):
- Building a feature → `incremental-implementation` + `test-driven-development`
- Something breaks → `debugging-and-error-recovery`
- Committing / PRs → `git-workflow-and-versioning`

These sequence the work; the standards and stop-list above still bind.

---

## The stop-list — never do these without explicit human sign-off

These are absolute. If a task requires one of these, STOP and ask first.

1. **Touch authentication, authorization, or sessions.** Getting this wrong exposes
   every user. A human reviews any change here.
2. **Change the database schema or write a migration.** A wrong migration can lose
   client data and is hard to undo. Propose it, don't run it.
3. **Upgrade an existing dependency.** A version bump changes behavior in ways a diff
   does not show. Name the package and the target version; wait for approval.
   Adding a *new* dependency is not on this list — it is reviewed at the pull request
   via the manifest diff. Justify it in the PR description.
4. **Handle real client or personal data.** Never paste real user data into prompts,
   logs, tests, or fixtures. Use fake data.
5. **Commit anything secret.** API keys, tokens, passwords, `.env` contents. If you
   need a secret, reference it by name from the environment — never inline it.

If a requirement is ambiguous, or you find yourself assuming something to make it
work, that is also a stop: flag it in `docs/open-questions.md` and ask.

---

## Non-negotiables for all code

- Write tests alongside code. Run them before saying anything is done.
- If you can't explain in plain English what a block of code does, don't ship it.
- Prefer boring, proven solutions over clever ones.
- No secrets in the repo. Ever.

---

## For the humans on this team

New to working with AI on code? Read `.ai/engineering/how-we-work-with-ai.md` first.
It's written in plain language and takes ten minutes.
