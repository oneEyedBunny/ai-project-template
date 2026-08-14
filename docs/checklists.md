# Checklists

Two lists that outlive any one feature: what to do once at the start of a project, and
what has to be true before handing it to the client.

Neither is a work queue. Feature work goes in GitHub Issues, and the task breakdown for
whatever is in flight is `tasks/todo.md`, written by the `spec-driven-development` skill
and replaced each feature. These lists are here because they are durable and would be
destroyed by that.

## Project init (do these once, when the stack is chosen)

Files to edit. The settings and generated config that go with them are `docs/setup.md`;
this list doesn't repeat it.

- [ ] Declare the client/server seam in `.ai/engineering/architecture.md` — this one is
      not deferrable; see the note there
- [ ] Fill in the enforcement table in `.ai/engineering/stack.md` — the config files are
      generated from it, in `docs/setup.md`
- [ ] Rewrite the `standards.md` examples in the project's language, or confirm the
      project is TypeScript and leave them
- [ ] Decide whether `persona.md` / `standards.md` / `patterns.md` are this client's
      deliverable (record in `.ai/client/constraints.md` — see `docs/handoff.md`)

---

## STANDING: final client handoff checklist (DO NOT SKIP)

The failure mode this guards against is **abandonment** — the client owns a repo they
can't actually operate. It lives here permanently so it can't be forgotten. Work through
every box before handing over. See `docs/handoff.md` for the reasoning.

**Can they run it?**
- [ ] README covers: what the app is, how to run it locally, how to deploy it
- [ ] A person who has never seen the project followed the README start to finish and
      got it running — actually tested, not assumed
- [ ] `.env.example` lists every env var the app reads, with a note on where real
      values come from

**Do they own it?**
- [ ] Repo ownership transferred to the client's GitHub org (or their account)
- [ ] Their team's access confirmed working — someone on their side has pushed or
      opened a PR successfully
- [ ] Branch protection **still** enabled on `master` in their org — opened the settings
      and looked, not assumed from having set it at project init
- [ ] "Decision records are append-only" still required on that rule, and the
      `amend-decision` label still exists in their repo
- [ ] `.github/CODEOWNERS` points at someone with write access in *their* org, or the file
      is deleted — our handle stops working the moment ownership moves, and every PR
      touching `/.github/` or `/scripts/` blocks with an error that doesn't explain itself

      These three are verifications, not a repeat of `docs/setup.md`. They read the same
      and are not — see "What transferring ownership breaks" in `docs/handoff.md`.
- [ ] Any third-party accounts we set up (hosting, DB, APIs, domains) are in their
      name or transferred, and billing points at them

**Can they maintain it?**
- [ ] Secrets rotated off anything tied to us; the client holds the current values
- [ ] `docs/decisions-log.md` and the ADRs explain the non-obvious choices
- [ ] `.ai/client/glossary.md` is current — it's the file that saves the next dev
- [ ] Open items are written down in `docs/open-questions.md`, not left verbal
- [ ] They know we built with AI, what `.ai/` is for, and how to keep using it
- [ ] Structural boundary contract in `.ai/engineering/architecture.md` is resolved:
      either declared, or recorded as a deliberate "no boundaries worth contracting."
      This is the deadline for it — see the status marker in that file.
- [ ] The as-built check is **answered in writing**, including when the answer is
      "no divergence." Leave it blank and it's indistinguishable from clean. Where the
      code disagrees with the declared contract, say where — that gap is the one thing a
      successor cannot reconstruct from the code, and it's the item most likely to get
      dropped under delivery pressure because writing it down reads as admitting mess.
