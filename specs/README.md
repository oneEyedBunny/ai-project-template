# Specs

Feature specs live here. One folder per feature, numbered in the order they're started:

```
specs/
  _template/spec.md        Copy this to start a new one
  001-feature-name/
    spec.md                Required. The what and the why.
    plan.md                From spec-driven-development. The technical approach.
    tasks.md               From spec-driven-development. The breakdown.
    notes.md               Optional. Scratch, sketches, links.
```

`spec.md` is the only required file you write by hand. `plan.md` and `tasks.md` come out
of the `spec-driven-development` skill, which turns an agreed spec into a technical plan
and then into tasks sized to land in one session. `incremental-implementation` executes
them, slicing riskiest-first and re-cutting the list when an early slice proves it wrong.

So the breakdown *is* written before the work — but it's a starting point, not a
contract. Expect it to change by the second slice; that's the incremental skill doing its
job, not the plan having failed.

**Where those files go, because the skill defaults elsewhere.** Its convention is
`tasks/plan.md` and `tasks/todo.md` at the repo root. Here they live in the feature's own
folder, named as above. Two reasons: one feature stays one folder, and a root
`tasks/todo.md` would sit next to `docs/todo.md` — the cross-feature work queue and
handoff checklist — which are different things that would be read as the same one.

## How the layers compose

- `specs/` — the **what** and the **why** for one feature.
- `.ai/engineering/` — the **how**: standards, architecture, approved patterns.
- `.ai/client/` — the **why** behind the product: domain, glossary, constraints.

A spec that restates the standards is doing the engineering layer's job. Link, don't copy.

## The bar

Non-trivial features start here. If we can't write the spec, we don't understand the
feature well enough to build it yet — that's the point of the step, not a formality.

A spec is ready when someone who wasn't in the conversation could build the feature
from it and know when they were done. Unresolved unknowns don't block writing the
spec; list them under "Open questions" and mirror anything blocking into
`docs/open-questions.md`.
