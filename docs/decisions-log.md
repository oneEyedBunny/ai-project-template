# Decisions log

A running, lightweight record of choices made during the build. Not every choice —
just the ones where someone might later ask "why did we do it that way?" that aren't
big enough to be a full ADR.

This is also part of Claude's memory across sessions: the repo remembers what the chat
forgets. When you make a call mid-build, drop a line here.

Format: newest at the top.

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
