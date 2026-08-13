# Open questions

Things blocked on a human decision — usually the client. This is the translation queue:
Claude parks a question here instead of guessing; you phrase it in plain language for
the client and bring the answer back.

An open question is a *risk*, not just a note. Either work is blocked, or worse, we might
proceed on a wrong assumption. Keep this list short by resolving items, not by ignoring
them. When answered, move the resolution into `decisions-log.md` and delete it here.

Format: open items at the top, grouped loosely by urgency.

---

## Open

### What keeps the two stop-list copies in sync?
**Context:** `CLAUDE.md` is authoritative; `.ai/engineering/how-we-work-with-ai.md` keeps
a plain-language copy for teammates new to AI coding, marked as non-authoritative. That
copy is deliberate — that file is standalone onboarding and a pointer would send a
beginner into a document addressed to Claude — but it is still a second copy of the
highest-stakes list in the repo. It already drifted once, within one editing session,
which is what surfaced it.

Marking one copy authoritative resolves *which* is right. It does nothing to make anyone
notice when they disagree. The append-only records got a CI check for exactly this class
of problem; this has prose only.

**Options as I see them:** (a) a CI check that fails when the stop-list item count or
headings diverge between the two files — cheap, catches structural drift, misses reworded
reasons; (b) put the canonical list in one file and generate the plain-language copy from
it at build time — no drift possible, but adds a build step to a docs-only repo; (c)
accept it, and add "re-read both stop-lists" to the handoff checklist — honest, weakest;
(d) accept it silently, on the grounds that the list changes about once a year.
**Who needs to decide:** Ally. Not blocking anything — raised because the same reasoning
that justified the immutability check applies here and reached a different answer.
**Raised:** 2026-08-13

### [Question — one line]
**Context:** why this matters / what's blocked
**Options as I see them:**
**Who needs to decide:**
**Raised:** [YYYY-MM-DD]

<!-- EXAMPLE:
### When a booking is cancelled, is the deposit refunded?
**Context:** Blocks the cancellation flow. Affects refunds, messaging, and records.
**Options:** (a) always refund, (b) refund if >48h notice, (c) never refund.
**Who needs to decide:** The client — this is a business/policy call, not technical.
**Raised:** 2026-01-22
-->

---

## Resolved (recently — for reference before they move to the decisions log)
