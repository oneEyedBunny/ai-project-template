# ADR-0001: Record architecture decisions

> This is a template AND a working first record. Copy this format for each new decision:
> `adr/NNNN-short-title.md`. Number them in order. Never delete an ADR — if a decision
> is reversed, write a new ADR that supersedes it and link back.
>
> This directory is append-only and CI enforces it: a pull request that deletes, renames,
> or removes a line from any ADR fails the "Decision records are append-only" check.
> Supersede by ADDING a line to the old ADR — `**Superseded by ADR-0007**` — rather than
> by editing its Status. See the header of `docs/decisions-log.md` for the reasoning.

> **Before writing an ADR that changes a module boundary, a dependency direction, or a
> public interface:** check whether the structural boundary contract in
> `architecture.md` still says NOT YET DECLARED. If it does, declaring it is part of
> *this* ADR, not a follow-up. You cannot judge that an ADR is needed under that
> criterion without knowing the boundaries, so this is the moment they get written down.
> The obligation lives here because this is where you'll be standing when it applies.

**Status:** Accepted
**Date:** [YYYY-MM-DD]

## Context

We're building software where the *why* behind technical choices matters as much as the
*what* — a small team, a non-technical client, and AI doing much of the coding. Without
a record of why we chose things, we (and the AI) will re-litigate settled decisions and
sometimes contradict them.

## Decision

We record every significant architecture and technology decision as an ADR: a short,
numbered markdown file capturing the context, the decision, and the consequences. One
file per decision, in this directory.

## Consequences

**Good:** Decisions have a durable rationale. New teammates and the AI can read why
things are the way they are. We stop re-deciding.

**Cost:** A few minutes to write each one. Worth it for anything non-obvious.

## What counts as "significant"

Choosing a framework, a data store, an auth approach, an offline-sync strategy, a
hosting platform — anything where a reasonable person might later ask "why did we do it
*this* way?" Routine implementation choices don't need an ADR.

---

<!-- EXAMPLE of a real one you'd write next:

# ADR-0002: Use a backend-as-a-service instead of a custom backend

**Status:** Accepted
**Date:** 2026-01-20

## Context
Small non-technical client, tight budget, one primary developer. We need auth, a
database, and a sync endpoint. A custom backend is more control but more to build,
host, and maintain.

## Decision
Use [BaaS] for auth, database, and sync.

## Consequences
Good: far less to build and maintain; auth handled by specialists.
Cost: vendor lock-in; recurring cost above the free tier; less control at the edges.
-->
