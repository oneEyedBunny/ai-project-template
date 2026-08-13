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
### One-time setup for a repo created from this template

Do these in order — steps 1 and 2 depend on each other.

1. **Let the check run once.** Push `.github/workflows/decisions-immutable.yml`, then
   open a throwaway pull request so the check executes. A check that has never run does
   not appear in the required-status-checks picker, so doing this the other way round
   looks broken and isn't.
2. **Require the check.** Settings → Branches → require the status check named
   "Decision records are append-only". (On a repo using rulesets rather than classic
   branch protection, this is Settings → Rules → Rulesets instead.)
3. **Create a PR label named `amend-decision`** (Issues → Labels). It is the sanctioned
   override for the immutability check, and using it leaves a visible mark on the PR.
   You need it at least once per repo, to clear this template's placeholder entries.
4. **Create `.github/pull_request_template.md`.** Structure is the team's call, but it
   must force an explicit answer to: does this change a documented standard, and was
   that standard updated in this PR?
5. **Wire pre-commit hooks for the chosen stack.** `.ai/engineering/standards.md` states
   that types, linter, and formatter run on every commit — until this step is done, that
   statement is not true of the project.
6. **Add `.github/workflows/` to `CODEOWNERS`** so enforcement cannot be weakened
   without review.
