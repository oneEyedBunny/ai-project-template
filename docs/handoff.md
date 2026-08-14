# Handoff process

How the project reaches the client as something they can own, run, and keep building on
after we're gone. The work happens in one repo — the client's — and everything in it
ships. Nothing is staged, filtered, or scrubbed at the end.

We build with AI and we say so. The `.ai/` context files are part of the deliverable:
they're how a future maintainer (human or AI) picks this codebase up without re-deriving
every decision.

> **Looking for the GitHub settings to turn on?** Those are day-one work, not handoff
> work — `docs/setup.md`. What's below is the delivery end: confirming they survived.

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

## What transferring ownership breaks

Handing the repo to the client's GitHub org is not a no-op for the settings in
`docs/setup.md`. The matching item in `docs/checklists.md` is a *verification*, not a
repeat of setup — the two look identical and are not.

- **`CODEOWNERS` breaks by definition.** The handle in `.github/CODEOWNERS` is ours, and
  once the repo belongs to the client's org that account may have no write access there —
  which makes every pull request touching `/.github/` and `/scripts/` unapprovable, with
  an error that does not explain itself. Repoint it at someone on their side who can
  approve, or delete the file. Leaving our handle in it is the worst of the three.
- **Branch protection, the required status check, and the label:** open the settings after
  the transfer and confirm each is still in force. Don't infer it from having set it once.
  Availability can depend on the owning org's plan rather than on the repo, so a rule that
  worked for us may arrive inert — check rather than assume, in either direction.

If any of the setup steps were never done at all, the repo has been running without them,
and the files that assert enforcement have been wrong for the whole project. Fix that
before delivering, not after.

## Final handoff

Work the checklist at the bottom of `docs/checklists.md`. It's short, and it's mostly
about access and operability — the things that are invisible until they're missing.
