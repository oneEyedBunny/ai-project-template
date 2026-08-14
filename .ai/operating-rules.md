# Operating rules — workflow and definition of done

How work moves from idea to shipped. Reusable across clients.

## The loop

1. **Spec first.** Non-trivial features start with a spec in `specs/` — copy
   `specs/_template/spec.md` into `specs/00N-feature-name/spec.md` and fill it in.
   The `spec-driven-development` skill carries it from there into a technical plan and a
   task breakdown, in `tasks/`. See `specs/README.md` for the convention. No spec for a
   real feature means we don't yet understand it well enough to build it.
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

`.ai/workflow/definition-of-done.md`, in full and in one place. Work through it there
rather than from memory — several boxes carry conditions that a summary loses, and the
one this file used to carry had already lost the condition that an unconfigured linter
makes that box *unavailable* rather than passing.

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

## What an automated check can actually do

Every check cheap enough to run here matches strings — the append-only guard on decision
records, and anything similar added later. String matching catches *structural* edits: a
line removed, a file renamed, a section left untouched. It misses *semantic* ones. Restate
a rule in different words and it passes clean.

So the ceiling is not preventing divergence. It is making divergence deliberate — turning
"nobody noticed" into "someone chose this, and left a mark." That is worth building, and
it is all that is on offer at this price. A check advertised as doing more is either
expensive (a model in the loop, a generated artifact) or lying, and a lying check is worse
than none: people stop looking at what it claims to cover.

### When a check earns its place

Two conditions, both required:

1. **It fires on a change, not on elapsed time.** A check triggered by the calendar
   carries no information about whether anything actually needs doing, so it gets
   dismissed on reflex — and that habit generalizes to the checks that *do* carry
   information. A time-based nag is worse than no check at all.
2. **It can see the thing that goes wrong.** Match the check to the real failure mode,
   not to whatever is cheapest to inspect. Reaching for the cheap signal and then
   reasoning about the risk in terms of what that signal happens to see is how you end up
   guarding the wrong thing confidently.

Worked examples from this repo: a date-based reminder to write the boundary contract fails
(1). A check comparing stop-list item counts and per-item slugs fails (2) — the only real
drift kept every item identity intact and changed one item's *scope*. A co-change check —
fail the pull request when one copy of a duplicated rule changes and the other doesn't —
passes both, which is why that's the shape that survived.

## Nothing pushed straight to the default branch

The default branch on this repo is **`master`**. Branch from it and target pull requests
at it — there is no `main`.

All work goes through a branch and a pull request. `master` is protected. This is a
GitHub setting, not a file — `docs/setup.md` has how to enable it. On a repo where that
step was skipped, this section describes an intention rather than a control.
