# Specs

Feature specs live here. One folder per feature, numbered in the order they're started:

```
specs/
  _template/spec.md        Copy this to start a new one
  001-feature-name/
    spec.md                Required. The what and the why.
    notes.md               Optional. Scratch, sketches, links.
```

`spec.md` is the only required file. From there the `spec-driven-development` skill
writes a technical plan and a task breakdown, sized so each task lands in one session.
`incremental-implementation` executes them, slicing riskiest-first and re-cutting the
list when an early slice proves it wrong.

So the breakdown *is* written before the work — but it's a starting point, not a
contract. Expect it to change by the second slice; that's the incremental skill doing its
job, not the plan having failed.

**The plan and task list live at `tasks/plan.md` and `tasks/todo.md`**, the skill's own
convention, not in the feature folder. They're working state for whatever is in flight —
the skill writes the same two paths every time, so starting the next feature replaces
them. That's the right shape for a scratch plan and the wrong shape for a record, which
is why they don't belong beside the spec.

Don't confuse `tasks/todo.md` with `docs/todo.md`. Same basename, unrelated jobs: this
one is the current feature's task breakdown and is disposable, that one is the standing
work queue and the handoff checklist.

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
