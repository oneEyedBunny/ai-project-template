# Handoff process

How the project reaches the client as something they can own, run, and keep building on
after we're gone. The work happens in one repo — the client's — and everything in it
ships. Nothing is staged, filtered, or scrubbed at the end.

We build with AI and we say so. The `.ai/` context files are part of the deliverable:
they're how a future maintainer (human or AI) picks this codebase up without re-deriving
every decision.

## The bar

Handoff is done when someone who has never seen this project can clone it, run it, deploy
it, and make a change — without asking us anything.

That means the failure mode to guard against isn't exposure, it's **abandonment**: a repo
they technically own but can't operate. Every item below exists to close that gap.

## What ships

Everything in the repo. `src/`, the specs, the decisions log, the ADRs, the glossary, the
`.ai/` context. The only judgment call is whether *our reusable methodology* files
(`persona.md`, `standards.md`, `patterns.md`) are this client's deliverable or our own
tooling that happens to live here — decide that per engagement, up front, and write the
answer in `.ai/client/constraints.md`.

Since everything ships, write it delivery-ready the first time. There is no cleanup pass.

## Do these continuously, not at the end

The whole point of building in the client's repo is that handoff stops being an event.
Keep these current as you go:

- `README.md` — what it is, how to run it, how to deploy it. Update it when those change.
- `.env.example` — every env var the app reads, documented, no real values.
- `docs/decisions-log.md` — the *why* behind non-obvious choices, written when you make
  them, not reconstructed later.

## Final handoff

Work the checklist at the bottom of `docs/todo.md`. It's short, and it's mostly about
access and operability — the things that are invisible until they're missing.

## The GitHub settings that aren't files

- **Branch protection** on `master`: Settings → Branches → require a pull request before
  merging. This enforces "nothing pushed straight to master," which written rules alone
  can't guarantee.
- **Template repository** (this template repo only, not client projects): Settings →
  check "Template repository" so each new client is one click via "Use this template."
- **Required status check: "Decision records are append-only."** The workflow ships as a
  file (`.github/workflows/decisions-immutable.yml`), but making it *block* a merge is a
  UI setting: Settings → Branches → the `master` rule → require status checks to pass →
  add it by name.

  **Order matters here.** A check does not appear in that picker until it has run at
  least once, so: push the workflow → open a throwaway PR so it runs → then come back
  and mark it required. Doing it in the other order looks broken and isn't.

  The escape hatch is a PR label named `amend-decision` — create it under Issues →
  Labels. With that label on, the check reports the violation and passes anyway. You need
  it once per repo to clear the template's placeholder entries.
