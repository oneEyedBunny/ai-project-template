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

### Should payments, data integrity, and sync be stop-list items, not just high-risk?
**Context:** An adversarial review found `definition-of-done.md` claiming those three were
"flagged and approved by a human before building (per the stop-list)" when the stop-list
covers neither. The false cross-reference is fixed; the underlying policy question isn't.

Today they get a second-LLM adversarial review but no human sign-off gate, so an agent
can build payment routing or offline-sync conflict resolution start-to-finish without
pausing. Both are areas where a confident-but-wrong implementation is expensive and hard
to spot in review.

**Options as I see them:** (a) add payments and the sync boundary to the stop-list — the
reviewer's implied fix, at the cost of the list firing more often, which the drift-hardening
entry warns trains people to route around it; (b) leave the split — adversarial review is
the right-sized gate for "hard to get right" and sign-off is reserved for "hard to undo";
(c) add only the sync boundary, since data loss there is irreversible in a way a payments
bug usually isn't.
**Who needs to decide:** Ally. Not urgent — no payments or sync code exists yet — but it
should be settled before either does.
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
