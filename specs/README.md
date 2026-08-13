# Specs

Feature specs live here. One folder per feature, numbered in the order they're started:

```
specs/
  _template/spec.md        Copy this to start a new one
  001-feature-name/
    spec.md                Required. The what and the why.
    notes.md               Optional. Scratch, sketches, links.
```

`spec.md` is the only required file. The build sequence (slices, tasks, commits) is
owned by the `incremental-implementation` skill at build time, not written up front —
a task list authored before the work starts is stale by the second slice.

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
