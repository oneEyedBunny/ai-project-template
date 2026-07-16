# Architecture

> FILL THIS IN as the design takes shape. This is the map: the major pieces, how they
> talk, and where things live. Keep it high-level — details live in code and specs.
> A cleaned version of this may be worth handing to the client (see `docs/handoff.md`).

## System overview

**One-paragraph description of the whole system:**

**Diagram / sketch:** (link or describe the major pieces and how data flows)

## Major components

> List the main parts and what each is responsible for. Keep responsibilities crisp —
> one clear job each.

- **[Component]** — responsible for:
- **[Component]** — responsible for:

## Data flow

**How a typical request/action moves through the system:**

**Where state lives:** (server, client, local storage, cache)

**The offline/sync boundary:** (what works offline, how conflicts resolve when back online)

## Boundaries and trust

**What we treat as untrusted input:** (network, URL, local storage, user input)
**Where validation happens:**

## Architecture Decision Records

Significant "why we chose X over Y" decisions live as individual files in `adr/`.
Add a line here each time one is written.

- ADR-0001: [title] — see `adr/0001-*.md`

<!-- EXAMPLE (delete when filling in):
## Major components
- **PWA client** — the whole UI; works offline; owns the local cache of bookings.
- **Backend-as-a-service** — auth, database, and the sync endpoint.
## Data flow
When a user makes a booking offline, it's written to local storage and queued. On
reconnect, the queue syncs to the backend; conflicts resolve last-write-wins with a
warning surfaced to the user.
-->
