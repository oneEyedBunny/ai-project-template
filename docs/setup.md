# Project setup

Day one of a repo created from this template. Everything here is a GitHub setting rather
than a file, which is exactly why it gets missed — nothing in the repo can enforce it and
nothing will fail loudly if you skip it.

Do this when the repo is created, not at handoff. Several of the steps make statements
elsewhere in the repo *true*; until they're done, those files are asserting enforcement
that does not exist. `docs/handoff.md` covers the other end of the engagement — verifying
these are still in force once the client owns the repo.

> **Two places do this, and picking the wrong one wastes an afternoon.** GitHub has
> *rulesets* (Settings → **Rules → Rulesets**) and older *branch protection*
> (Settings → **Branches**). A repo normally uses one or the other, and the page for the
> one you aren't using is simply empty — which reads as "this feature is broken," not
> "wrong page." Check which you have first; the paths below name both.

Do these in order — steps 2 and 3 depend on each other.

1. **Protect `master`**: require a pull request before merging. This enforces "nothing
   pushed straight to master," which written rules alone can't guarantee.
   Rulesets → add a rule targeting `master` → Require a pull request before merging.
   Branch protection → add a rule for `master` → same option.

2. **Let the append-only check run once.** Push
   `.github/workflows/decisions-immutable.yml`, then open a throwaway pull request so the
   check executes. A check that has never run does not appear in the required-status-checks
   picker, so doing this the other way round looks broken and isn't.

3. **Require the check.** Turn on "Require status checks to pass" and add the check named
   **"Decision records are append-only"**.
   Rulesets → your `master` ruleset → Require status checks to pass.
   Branch protection → the `master` rule → same option.

4. **Create a PR label named `amend-decision`.** It is the sanctioned override for the
   immutability check. You need it at least once per repo, to clear this template's
   placeholder entries out of `docs/decisions-log.md`.

   ```bash
   gh label create amend-decision --force \
     --description "Sanctioned override for the append-only decision-records check" \
     --color d4c5f9
   ```

   `--force` updates the label instead of erroring if it already exists, so re-running
   setup on a partly configured repo doesn't halt here. By hand: Issues → Labels.

   **The label is a mark, not a gate.** It records that an edit was deliberate and makes
   it visible on the pull request — it does not require anyone to approve. Note that
   requiring a *pull request* (step 1) is not the same as requiring an *approving review*,
   which is a separate option. With neither required approvals nor a second person on the
   repo, the check's "make sure a reviewer actually looked at it" is an honor system and
   nothing enforces it. Turn on required approvals once there are two people; until then
   the label is a note to yourself, so read the diff.

5. **Create `.github/pull_request_template.md`.** Structure is the team's call, but it
   must force an explicit answer to: does this change a documented standard, and was that
   standard updated in this PR?

6. **Wire pre-commit hooks and CI for the chosen stack.** `.ai/engineering/standards.md`
   states that types, linter, and formatter run on every commit — until this step is done,
   that statement is not true of the project. This is the step most worth doing early: the
   window before it exists is exactly when the first feature gets written.

7. **Point `CODEOWNERS` at a real reviewer, and require code-owner review.** The file
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

   What it closes: the workflow runs the check script from the base branch, so editing
   that script inside a PR can no longer blind the check gating it. But for
   `pull_request` events GitHub runs the *workflow file* from the PR branch — so a pull
   request that guts the job body while keeping the job name still reports success to the
   required status check. No workflow can defend against edits to itself. That is the
   remaining hole, and only a human reading the diff closes it.

## For this template repo only

**Template repository**: Settings → check "Template repository" so each new client is one
click via "Use this template." Not something a client project needs.
