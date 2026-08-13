# Definition of done

A piece of work is not done until every box here is true. Claude checks this before
declaring anything complete; the human reviewer checks it at the pull request.

## Every change

- [ ] The code does what the spec / issue asked, and nothing it didn't ask for.
- [ ] Tests exist for the new behavior and they pass.
- [ ] A bug fix includes a test that would have caught the bug.
- [ ] Linter passes. *(If no linter is configured yet, this box is not "done by default"
      — it's unavailable. Say so rather than ticking it; see project init in
      `docs/todo.md`.)*
- [ ] Formatter passes (code is formatted). Same caveat as above.
- [ ] Type-checker passes, and every new suppression of it carries a reason — whether
      that's a silent cast or a suppression directive. See the Types rule in
      `.ai/engineering/standards.md`; the language-specific forms live there, not here.
- [ ] No secrets anywhere (keys, tokens, passwords, `.env` contents).
- [ ] No real client or user data in code, tests, fixtures, or logs.
- [ ] A human on the team can explain, in plain English, what the code does.
- [ ] Names match the domain glossary.
- [ ] Notable decisions recorded in `docs/decisions-log.md`.
- [ ] Any assumption or blocker recorded in `docs/open-questions.md`.

## If it touches a high-risk area (auth, payments, data integrity, migrations, sync)

Two different gates apply here, and they cover different lists. Don't conflate them.

- [ ] A second LLM did an adversarial review. This applies to **every** area named above —
      see `review-checklist.md`.
- [ ] **If, and only if, the change is on the stop-list in `CLAUDE.md`** — it was flagged
      and approved by a human *before* building. The stop-list is narrower than this
      heading: it covers auth and migrations, not payments, data integrity, or sync.
      Don't tick this for something the stop-list doesn't actually cover; an untrue tick
      certifies an approval that never happened.
- [ ] The offline/sync behavior is explicit and tested, if relevant.

## Before merge

- [ ] On a branch, not `master`.
- [ ] Pull request opened and reviewed by a human.
- [ ] CI is green.
