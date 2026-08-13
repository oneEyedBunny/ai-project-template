# Architecture

> FILL THIS IN as the design takes shape. This is the map: the major pieces, how they
> talk, and where things live. Keep it high-level — details live in code and specs.
> This ships to the client, so write it for them as well as for us.

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

## Boundary contract

What may import what. Two parts, and they are declared at different times on purpose.

### 1. The client/server seam — declare this at init

Applies to any repo with a server side, or a client that talks to privileged code. You
know which at repo creation; nothing about the code has to exist first.

This is not a style preference and it is not optional the way the shapes below are.
Importing a server-only module into client code puts its secrets in the shipped bundle.
That is a security failure, not an architecture smell, and no amount of "we'll tidy it
later" recovers a key that went out in a build.

- **Server-only modules** (secrets, DB clients, privileged APIs):
- **Client-safe modules:**
- **What must never cross, and how it's enforced:**

### 2. The structural shape — declare this at the first ADR that needs it

Pick one when the time comes, delete the others:

- **Layered** (backend-shaped): an ordered list of layers, highest to lowest. Imports go
  down only, including indirectly through chains.
- **Feature / shared / ui** (frontend-shaped): features may use shared and ui; shared and
  ui never reach back into a feature; features don't import each other.
- **Blended**: one of the above *plus* the seam in part 1, which outranks it.

> **Status: NOT YET DECLARED — due at the first ADR that changes a module boundary, a
> dependency direction, or a public interface, or at handoff, whichever comes first.**
>
> This marker is load-bearing and stays until it stops being true. An absent section
> reads as "there is no contract," and a bare placeholder reads as forgotten. This has to
> read as *parked, with a date it comes due* — an agent, and a successor, treat the three
> identically otherwise and pick their own structure.

**Why this half waits.** You cannot name module boundaries before there are modules, and
a contract invented from a template default doesn't get followed, it gets *built*: an
agent reading `domain → application → infrastructure` will create those folders for a
three-file app, and every file written afterward reinforces them. Premature structure is
expensive to remove. Late structure is only late, and `standards.md` still binds meanwhile.

**What forces it to actually get written.** The ADR criterion below fires when a decision
changes a module boundary, a dependency direction, or a public interface — and that
criterion cannot be applied by someone who doesn't know what the boundaries are. So the
first ADR that trips it is the moment this section gets filled in. Writing the contract is
part of that ADR, not a follow-up.

**Two triggers, and they produce different artifacts.** The ADR trigger fires at the
decision moment. Handoff is the backstop for the case where it never fired at all —
because the criterion above is not self-firing, and the person establishing a boundary by
accident is the one least likely to notice they've done it. Both are needed, and what each
one writes is not the same thing:

- **At the ADR, the contract is a constraint.** The build is in progress; its job is to
  rule things out.
- **At handoff, the contract is a description.** The structure is already set. Writing it
  as a constraint hands the successor a picture of the architecture you wish you'd built,
  which is worse than nothing — they'll trust it. Write what is actually true.

**If a contract already exists at handoff, do not rewrite it — annotate it.** Leave the
declared contract exactly as written and add a dated block underneath, e.g.
`**As-built check, 2026-11-02:** no divergence.` or `**As-built check, 2026-11-02:**
features/billing imports features/scheduling directly, which the contract above forbids.
Known, not fixed — see decisions-log.`

Same shape as the supersession convention in `docs/decisions-log.md`: never edit the
original, add a marked line. Replacing the contract destroys the evidence that the code
drifted, which is exactly what a successor needs. Keeping two contracts side by side
leaves them unable to tell which one governs.

Name the tool that enforces whichever shape you pick in the `stack.md` enforcement table.
Prose alone does not stop an import.

## Architecture Decision Records

Significant "why we chose X over Y" decisions live as individual files in `adr/`.
Add a line here each time one is written.

Use an ADR when the decision changes a module boundary, a dependency direction, or a
public interface. Everything else goes in `docs/decisions-log.md`.

Both paths are hardcoded in `scripts/check-decisions-immutable.sh`, which enforces that
these records are append-only. Moving `adr/` or `docs/decisions-log.md` means updating
the `GUARDED` list in that script, or the guard silently stops covering them.

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
