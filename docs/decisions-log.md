# Decisions log

A running, lightweight record of choices made during the build. Not every choice —
just the ones where someone might later ask "why did we do it that way?" For which
choices belong here and which get an ADR instead, see the test under "Architecture
Decision Records" in `.ai/engineering/architecture.md`.

This is also part of Claude's memory across sessions: the repo remembers what the chat
forgets. When you make a call mid-build, drop a line here.

Format: newest at the top.

## When a decision goes stale

Entries are append-only. Never edit or delete a past decision — the value of this log is that
it records what was believed at the time, which is exactly what someone wants to know when a
decision turns out badly.

When something changes, write a new entry at the top, then add one line to the top of the old
entry:

**Superseded 2026-03-14** — see the entry above.

If only part of it changed, say which part:

**Superseded in part, 2026-03-14** — cost figure only; the vendor caveat below still stands.

Being specific matters: a bare "Superseded" throws away whatever is still true in the old
entry, and someone will act on that later.

There is no status field on every entry. An entry is only written once the call is made, so a
status would read the same on all of them — and a field that always says the same thing stops
being read.

CI enforces this. `scripts/check-decisions-immutable.sh` fails any pull request that removes
a line from this file or from `.ai/engineering/adr/`. Adding the **Superseded** line passes;
rewording the entry under it does not. If you genuinely need to edit — a typo, or clearing
the placeholders below — put the `amend-decision` label on the PR.

---

## 2026-08-13 — Drift-hardening pass on the template docs
**Decision:** Eight changes aimed at rules that drift because they are stated twice, or
stated too vaguely to apply the same way twice. Two are substantive; the rest are
plumbing.

The first substantive one: **decision records are append-only, enforced in CI.**
`scripts/check-decisions-immutable.sh` fails any PR that removes a line from
`docs/decisions-log.md` or `.ai/engineering/adr/`. Supersede by adding a line, never by
editing the old text. The `amend-decision` PR label is the sanctioned override.

The second: **the dependency policy split.** Adding a new package is no longer a
stop-list item — it is reviewed at the PR via the manifest diff, weighed against the new
selection rubric in `.ai/engineering/stack.md`. Only *upgrading* an existing package
needs sign-off, because a version bump changes behavior in ways the diff does not show.

The rest: a concrete ADR-vs-log test (module boundary, dependency direction, or public
interface → ADR), a stated duplication convention (repeat across layers, never within a
file), removal of a duplicated no-secrets bullet, and six one-time repo setup steps in
`docs/handoff.md`.

**Why:** The template's value is that a rule means the same thing on session 30 as on
session 1. A rule stated in two places drifts when only one copy is updated; a rule
stated as a vague judgment call about how weighty a decision feels is re-judged every
time. Both were present. Enforcement that lives in CI rather than in prose is the part
that cannot be forgotten.

**Alternatives considered:** Leaving the append-only rule as prose only — rejected, it is
exactly the kind of rule that erodes silently. Blocking new dependencies as well as
upgrades — rejected, it made the stop-list fire constantly for routine work, which trains
people to route around the whole list.

---

## [YYYY-MM-DD] — [short title]
**Decision:**
**Why:**
**Alternatives considered:**

<!-- EXAMPLE:
## 2026-01-22 — Client-generated IDs for offline bookings
**Decision:** Bookings created offline get a UUID generated on the client, not a
server-assigned ID.
**Why:** The booking must exist and be usable offline before the server ever sees it.
**Alternatives considered:** Temporary negative IDs (rejected — messy to reconcile).
-->
