# Handoff process

How code reaches the client without exposing our internal working files or the extent of
AI-assisted development. Decide the boundary up front (now); flow code to the clean side
continuously, so final handoff is a verification — not a last-minute scramble.

## The two-repo model

**This (private) working repo** — everything: `src/`, the full `.ai/` scaffolding,
decisions log, open questions, todos. The team works here. Claude codes here.

**Delivery repo — lives in the client's GitHub organization** — only what they receive:
`src/`, a real README, and the *keeper docs* (see below). Separate repo, separate
history, separate access. The client's org only ever sees the clean one.

Why two repos rather than a `handoff` branch: branches share history (past commits still
expose `.ai/`), and selective merges are fiddly and easy to get wrong — a real footgun
for a team still building git instincts. Separate repos give a clean history for free.

## What ships vs what stays

We use an **allowlist** — name what ships; anything not named stays out by default, which
is the safe direction to fail. The allowlist lives in `scripts/sync-to-delivery.sh`.

**Ships (keeper docs — genuine project-hygiene assets, cleaned of AI framing):**
- `src/` — the code
- `README.md` — client-facing: what it is, how to run and deploy
- `.ai/client/glossary.md` — the domain glossary (rename/relocate as plain docs)
- Cleaned `architecture.md` and `adr/` — the *what* and *why* of the design

**Stays (internal only — never ships):**
- `.ai/persona.md`, `.ai/operating-rules.md`
- `.ai/workflow/` (review checklist, definition of done)
- `.ai/engineering/how-we-work-with-ai.md`, `standards.md`, `patterns.md`
- `docs/decisions-log.md`, `docs/open-questions.md`, `docs/todo.md`, this file

> Decide keeper docs file-by-file per project. Good documentation is an asset worth
> delivering; the AI-process files are not. Since keeper docs ship, author them
> delivery-ready from the start so there's nothing to clean under deadline.

## Clean history

The delivery repo starts from its own fresh initial commit — don't clone or branch from
the working repo. That way the client's `git log` begins at "initial commit" and never
contains a commit that added the internal files. The sync script copies *current state*
into the delivery repo; it does not carry our history across.

## Step by step (each milestone, and finally)

1. Finish and review a feature in this repo.
2. Run `scripts/sync-to-delivery.sh /path/to/delivery-repo`.
3. In the delivery repo, review the diff, then commit with a clean plain message.
4. At final handoff, work the checklist in `docs/todo.md` — every box.

## The GitHub settings that aren't files

- **Branch protection** on `main` (both repos): Settings → Branches → add a rule for
  `main` → require a pull request before merging. This enforces "nothing pushed straight
  to main," which written rules alone can't guarantee.
- **Template repository** (this repo): Settings → check "Template repository" so each new
  client is one click via "Use this template."
