# Operating rules — workflow and definition of done

How work moves from idea to shipped. Reusable across clients.

## The loop

1. **Spec first.** Non-trivial features start with a spec in `specs/` — copy
   `specs/_template/spec.md` into `specs/00N-feature-name/spec.md` and fill it in.
   See `specs/README.md` for the convention. No spec for a real feature means we
   don't yet understand it well enough to build it.
2. **Tests as the target.** Turn the spec's acceptance criteria into tests, ideally
   before or alongside the implementation. "Make it work" becomes a concrete, checkable
   target instead of a vibe.
3. **Build.** Implement until the tests pass and the standards are met.
4. **Self-review** against `.ai/workflow/review-checklist.md` before declaring done.
5. **Human review.** Every change goes through a pull request. A human reviews it.
   For high-risk areas (see below), a second LLM reviews it too.
6. **Record.** Log any notable decision in `docs/decisions-log.md`. Move any resolved
   open question out of `docs/open-questions.md`.

## Definition of done

A piece of work is done only when ALL of these are true. See
`.ai/workflow/definition-of-done.md` for the full checklist. In short:
- Tests exist and pass.
- Linter, formatter, and type-checker pass.
- No secrets, no real user data.
- A human can explain what the code does.
- Decisions and open questions are recorded.

## When to bring in a second LLM (adversarial review)

This is a guardrail, not a default. Use a second strong model as a dedicated reviewer
for high-stakes code only:
- authentication / authorization
- anything touching money or payments
- data integrity and migrations
- public-facing APIs
- the offline-sync boundary (where stale or conflicting data can corrupt state)

For routine UI and CRUD, human review is enough — don't pay the review tax everywhere.
See `.ai/workflow/review-checklist.md` for the shared reviewer prompt and checklist.

## Nothing pushed straight to the default branch

The default branch on this repo is **`master`**. Branch from it and target pull requests
at it — there is no `main`.

All work goes through a branch and a pull request. `master` is protected. This is a
GitHub setting, not a file — see `docs/handoff.md` and the README for how to enable it.
