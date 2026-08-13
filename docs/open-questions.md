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

### Two files still say a new dependency needs sign-off — fix them, or was T1 wrong?
**Context:** T1 changed the `CLAUDE.md` stop-list so only *upgrades* need sign-off, with
new packages reviewed at the PR. The grep T1 asked for found two places that still say
the opposite, so the repo now contradicts itself:
- `.ai/engineering/how-we-work-with-ai.md:27` — its stop-list (explicitly "also in
  CLAUDE.md") lists "Adding a new dependency / library — each one is new risk; we decide
  together."
- `.ai/persona.md:38` — summarizes the stop-list as "auth, schema changes, new
  dependencies, real user data, and anything secret."

Not a contradiction, no action needed: `.ai/engineering/patterns.md:23` lists
"introducing a new dependency to solve something the stack already handles" as an
anti-pattern. That is about redundancy, not about who signs off.

**Options as I see them:** (a) update both files to match the new policy — mechanical,
and the one that makes T1's "done when" actually true; (b) revert T1 and keep new
dependencies on the stop-list; (c) leave the split deliberately and say why.
**Who needs to decide:** Ally. T1 said to report rather than fix silently, so both files
are untouched.
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
