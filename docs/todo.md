# Todo

Decided-but-not-yet-built work. This is the *execution* queue — no decisions pending
here (those live in `open-questions.md`).

> Recommendation: once the team is comfortable, move this to GitHub Issues. Issues are
> shared, link to pull requests, and fit the branch-per-task workflow better than a file.
> Keep this file only as a simple starting point, OR keep it just for the standing
> handoff items below, which don't map cleanly to a feature issue.

## In progress

## Up next

## Backlog

---

## STANDING: sync to delivery repo (do at every milestone — don't let it pile up)

The client-facing delivery repo should stay current so final handoff is a check, not a
scramble. At each finished, reviewed feature:

- [ ] Run `scripts/sync-to-delivery.sh` (copies only allowlisted paths)
- [ ] Confirm no `.ai/` or internal working files landed in the delivery repo
- [ ] Commit in the delivery repo with a clean, plain message

## STANDING: final client handoff checklist (DO NOT SKIP)

This is the one step whose failure mode is "the client sees everything." It lives here
permanently so it can't be forgotten. Work through every box before handing over.

- [ ] Final `scripts/sync-to-delivery.sh` run completed
- [ ] Delivery repo contains ONLY: `src/`, README, and the keeper docs
      (glossary, cleaned architecture notes / ADRs) — see `docs/handoff.md`
- [ ] Delivery repo has NO `.ai/persona.md`, operating-rules, review-checklist,
      decisions-log, open-questions, or todo
- [ ] Delivery repo git history is clean (fresh history — no commits exposing internal
      working files; see `docs/handoff.md`)
- [ ] Keeper docs read as normal professional documentation (no AI framing)
- [ ] Client README written: what the app is, how to run it, how to deploy
- [ ] Access to the delivery repo (in the client's GitHub org) confirmed working
- [ ] Branch protection enabled on the delivery repo's `main`
