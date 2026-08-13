# Technology stack

> FILL THIS IN per project. For each choice, record WHAT and WHY. The *why* is what
> stops Claude (and teammates) from second-guessing the choice or quietly swapping in
> an alternative out of habit. Pin versions so builds are reproducible.
>
> Once this is filled in, the root config files (linter, formatter, CI, pre-commit)
> get generated to match — those are the "automated guardrails" and they can't be
> generic. Ask Claude to generate them once the stack is settled.

## How a tool gets chosen

Evaluate against these before committing to anything. Record the result in the entry
for that tool, so a later reader can see what was weighed.

1. Weekly download trend — direction over the last year, not the absolute number.
2. Last release date. Nothing published in 12 months is a risk, not a stable tool.
3. Maintainers with commits in the last 6 months. One is a bus factor problem.
4. Median time to close an issue.
5. Whether tools already in this stack depend on it.

GitHub stars are not a criterion. They are lifetime-cumulative, never decay, and
measure a moment of attention rather than current health.

An AI assistant recommending a tool is pattern-matching on training data, not
consulting these numbers, and its knowledge has a cutoff. Treat any suggested tool
as a candidate to verify against the list above.

## Frontend framework
**Choice:**
**Why:**
**Version:**

## Build tool
**Choice:**
**Why:**
**Version:**

## PWA / offline strategy
**Choice:** (service worker approach, caching strategy)
**Why:**
**Version:**

> See `patterns.md` for the offline/caching rules in detail — "it's a PWA" is not
> enough for consistent decisions.

## Styling
**Choice:**
**Why:**

## Backend / data layer
**Choice:**
**Why:**
**Version:**

## Testing
**Choice:** (test runner, and any e2e tool)
**Why:**

## Linter
**Choice:**
**Why:**

## Formatter
**Choice:**
**Why:**

## Hosting / deployment
**Choice:**
**Why:**
**Recurring cost:** (flag if not free — see client constraints)

<!-- EXAMPLE (delete when filling in):
## Frontend framework
**Choice:** React
**Why:** Team knows it; huge ecosystem; easy to hire help later.
**Version:** React 19
## Build tool
**Choice:** Vite
**Why:** Fast dev server, simple PWA plugin, minimal config.
**Version:** Vite 6
-->
