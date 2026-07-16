# Definition of done

A piece of work is not done until every box here is true. Claude checks this before
declaring anything complete; the human reviewer checks it at the pull request.

## Every change

- [ ] The code does what the spec / issue asked, and nothing it didn't ask for.
- [ ] Tests exist for the new behavior and they pass.
- [ ] A bug fix includes a test that would have caught the bug.
- [ ] Linter passes.
- [ ] Formatter passes (code is formatted).
- [ ] Type-checker passes with no new escape hatches (`any`, ignores) left unexplained.
- [ ] No secrets anywhere (keys, tokens, passwords, `.env` contents).
- [ ] No real client or user data in code, tests, fixtures, or logs.
- [ ] A human on the team can explain, in plain English, what the code does.
- [ ] Names match the domain glossary.
- [ ] Notable decisions recorded in `docs/decisions-log.md`.
- [ ] Any assumption or blocker recorded in `docs/open-questions.md`.

## If it touches a high-risk area (auth, payments, data integrity, migrations, sync)

- [ ] It was flagged and approved by a human before building (per the stop-list).
- [ ] A second LLM did an adversarial review (see `review-checklist.md`).
- [ ] The offline/sync behavior is explicit and tested, if relevant.

## Before merge

- [ ] On a branch, not `main`.
- [ ] Pull request opened and reviewed by a human.
- [ ] CI is green.
