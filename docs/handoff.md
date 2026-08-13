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

> **Two places do this, and picking the wrong one wastes an afternoon.** GitHub has
> *rulesets* (Settings → **Rules → Rulesets**) and older *branch protection*
> (Settings → **Branches**). A repo normally uses one or the other, and the page for the
> one you aren't using is simply empty — which reads as "this feature is broken," not
> "wrong page." Check which you have first; the paths below name both.

- **Protect `master`**: require a pull request before merging. This enforces "nothing
  pushed straight to master," which written rules alone can't guarantee.
  Rulesets → add a rule targeting `master` → Require a pull request before merging.
  Branch protection → add a rule for `master` → same option.
- **Template repository** (this template repo only, not client projects): Settings →
  check "Template repository" so each new client is one click via "Use this template."
### One-time setup for a repo created from this template

Do these in order — steps 1 and 2 depend on each other.

1. **Let the check run once.** Push `.github/workflows/decisions-immutable.yml`, then
   open a throwaway pull request so the check executes. A check that has never run does
   not appear in the required-status-checks picker, so doing this the other way round
   looks broken and isn't.
2. **Require the check.** Turn on "Require status checks to pass" and add the check named
   **"Decision records are append-only"**.
   Rulesets → your `master` ruleset → Require status checks to pass.
   Branch protection → the `master` rule → same option.
3. **Create a PR label named `amend-decision`.** It is the sanctioned override for the
   immutability check, and using it leaves a visible mark on the PR. You need it at
   least once per repo, to clear this template's placeholder entries.

   ```bash
   gh label create amend-decision --force \
     --description "Sanctioned override for the append-only decision-records check" \
     --color d4c5f9
   ```

   `--force` updates the label instead of erroring if it already exists, so re-running
   setup on a partly configured repo doesn't halt here. By hand: Issues → Labels.
4. **Create `.github/pull_request_template.md`.** Structure is the team's call, but it
   must force an explicit answer to: does this change a documented standard, and was
   that standard updated in this PR?
5. **Wire pre-commit hooks for the chosen stack.** `.ai/engineering/standards.md` states
   that types, linter, and formatter run on every commit — until this step is done, that
   statement is not true of the project.
6. **Point `CODEOWNERS` at a real reviewer, and require code-owner review.** The file
   ships at `.github/CODEOWNERS` covering `/.github/` and `/scripts/` — the paths that
   contain the enforcement itself. Two things have to happen or it does nothing:

   - **Replace the handle** with someone who has write access to *this* repo. An owner
     without access can't approve, so every PR touching those paths blocks with an
     unhelpful error. A wrong handle is worse than no file.
   - **Turn it on:** require review from Code Owners — Rulesets → your `master` ruleset →
     the pull request rule, or Branch protection → the `master` rule. Without this,
     `CODEOWNERS` is advisory and the gap it closes stays open.

   **Skip this step on a one-person repo.** Code-owner review requires an approval from a
   code owner *other than the PR author*. If the only code owner is the only developer,
   every pull request touching these paths becomes unapprovable and gets cleared with an
   admin bypass instead. A control bypassed every time is worse than no control — it
   trains you past the bypass prompt for the cases that matter. On a solo repo, leave it
   off and accept that the gap below stays open; turn it on the moment there is a second
   person who can approve.

   What it closes: CI runs `scripts/check-decisions-immutable.sh` from the pull request's
   own branch, so a PR can delete a decision record and edit the script's `GUARDED` list
   in the same commit, and the check passes. The edit shows in the diff; this makes
   someone look at it.
