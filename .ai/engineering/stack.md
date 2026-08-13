# Technology stack

> FILL THIS IN per project. For each choice, record WHAT and WHY. The *why* is what
> stops Claude (and teammates) from second-guessing the choice or quietly swapping in
> an alternative out of habit. Pin versions so builds are reproducible.
>
> Once this is filled in, the root config files (linter, formatter, CI, pre-commit)
> get generated to match — those are the "automated guardrails" and they can't be
> generic. Ask Claude to generate them once the stack is settled.

## Enforcement — which tool owns which rule

`standards.md` states the invariants and deliberately holds no rule names and no enforced
numbers. This table is where they land. Fill it in when the stack is chosen; it doubles as
the spec for generating the config files.

| Invariant (from `standards.md`) | Tool + rule | Configured in |
| --- | --- | --- |
| Function length | | |
| Nesting depth | | |
| Type suppression carries a reason | | |
| **Client/server seam — security** (`architecture.md`) | | |
| Structural boundary contract (`architecture.md`) | | |
| Formatting | | |
| Types | | |

**The seam row is the one to fill in first, and it is unenforced until you do.** The seam
is declared at init because it's knowable then, but declaring it is prose — nothing stops
an import until a tool does. That leaves a window where the only security-relevant
boundary in the repo is guarded by a sentence. That window is probably unavoidable, since
the enforcer depends on the stack. It should be *conspicuous* rather than assumed covered,
which is what this row is for: leave it visibly blank, don't quietly skip it.

**The two right-hand columns do not deserve equal trust, and it matters which is which.**

*Configured in* is a path. It exists or it doesn't, so it's checkable by anything that
validates file references — the same class of check as link-checking, and it should be
covered by that rather than by something bespoke.

*Tool + rule* is not checkable without invoking the linter. It stays convention: this
column can name a rule that was renamed, deprecated, or switched off months ago, and
nothing will say so. Treat it as a lead — confirm against the config file before relying
on it, and never quote a number from here, because numbers don't live here.

## How a tool gets chosen

Evaluate against these before committing to anything. Record the result in the entry
for that tool, so a later reader can see what was weighed.

1. Weekly download trend — direction over the last year, not the absolute number.
2. Last release date. Nothing published in 12 months is a risk, not a stable tool.
3. Maintainers with commits in the last 6 months. One is a bus factor problem.
4. Median time to close an issue.
5. Whether tools already in this stack depend on it.
6. What it drags in — count of transitive dependencies and installed size. This is the
   one the pull-request review will not catch on its own: a manifest diff shows one added
   line, and the tree underneath it only appears in a lockfile diff nobody reads. A
   package that adds one direct dependency and ninety indirect ones is a different
   decision from one that adds none, and the PR makes those look identical.

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
