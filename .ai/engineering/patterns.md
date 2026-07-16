# Patterns and anti-patterns

Approved ways to do common things, and things to avoid. This grows over the life of the
project. When a pattern is decided, write it here so it's applied consistently instead
of re-decided each time.

## Approved patterns

> The blessed way to do recurring things in this codebase. Fill in as they're established.

- **State management:**
- **Data fetching / caching:**
- **Form handling and validation:**
- **Error handling and user-facing errors:**
- **Component structure:**

## Anti-patterns — do not do these

> Things that have bitten this project or that we've explicitly ruled out.

- Trusting data from local storage or the network without validating it first.
- Swallowing errors silently.
- Introducing a new dependency to solve something the stack already handles.

---

## PWA offline & caching (fill in — "it's a PWA" is not enough)

This section deserves special care. Offline behavior is exactly where AI-generated code
looks correct but is subtly broken. Be explicit.

**Caching strategy per resource type:**
- App shell (HTML/CSS/JS):
- API data:
- Images / assets:

**What must work fully offline:**

**What may show a "you're offline" state instead:**

**How writes made offline are queued:**

**How sync conflicts resolve when connectivity returns:**
(last-write-wins? merge? surface to user? — pick one and say why)

**How the user is told about offline/sync state:**
(a wrong or invisible sync state confuses non-technical users badly — be deliberate)

**Service worker update strategy:**
(how does a user get a new version? how do you avoid a stale cached app?)

<!-- EXAMPLE (delete when filling in):
**What must work fully offline:** Viewing today's bookings and adding a new booking.
**How writes are queued:** New bookings go to an IndexedDB queue with a client-generated
id and a `synced: false` flag.
**Conflict resolution:** Last-write-wins on the server, but if a booking the user created
offline collides with an existing slot, we DON'T silently drop it — we surface it as a
conflict the owner must resolve, because a lost booking is a real customer who showed up.
-->
