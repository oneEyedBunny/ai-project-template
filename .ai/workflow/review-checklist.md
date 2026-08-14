# Review checklist

Used two ways: by Claude for self-review before declaring done, and by a second LLM for
adversarial review on high-risk code. Sharing one checklist keeps reviews consistent.

## Self-review (Claude, before saying "done")

- Did I do what was asked and nothing extra?
- Are there tests, and do they pass?
- Any error I'm swallowing? Any unvalidated external data?
- Any name that doesn't match the glossary?
- Does this add a dependency? If so, it's weighed against the selection rubric in
  `.ai/engineering/stack.md` and the result is written into that tool's entry there — a
  PR description is where it gets reviewed, not where it lives. (Upgrading an existing
  one is a stop-list item — see `CLAUDE.md`.)
- Anything I assumed that a human should confirm? (→ `docs/open-questions.md`)
- Any part I couldn't fully explain in plain English? (If so, it's not ready.)

## Adversarial review (second LLM, high-risk code only)

Use a *different* strong model (e.g. if Claude built it, review with GPT or Gemini, and
vice versa). Different models have different blind spots; that's the whole point.

### Reviewer prompt (paste this, then the code and the standards)

> You are a staff engineer reviewing this code for correctness, security, and adherence
> to the attached engineering standards. Assume bugs exist and it is your job to find
> them. Focus especially on: edge cases, security holes, unvalidated input, error
> handling, and race conditions or stale-data problems at the offline/sync boundary. Do
> not praise the code. List concrete problems, most severe first, each with a specific
> fix. If you find nothing serious, say so plainly rather than inventing issues.
>
> [attach `.ai/engineering/standards.md` so it judges against OUR standards, not its own]
> [attach the code]
> [attach the relevant spec and glossary terms]

### Handling the findings

- Feed the findings back to the builder model to address, one by one.
- Where the two models disagree, don't auto-accept either — have the builder defend or
  revise, and use human judgment. The disagreement is usually where the real bug is.
- For the highest-stakes logic (auth, money, migrations), a quick second reviewer model
  (build with one, review with two) is worth it.

### When to use it

High-risk only: auth/authorization, payments, data integrity, migrations, public APIs,
the offline-sync boundary. NOT routine UI and CRUD — don't pay this tax everywhere.
