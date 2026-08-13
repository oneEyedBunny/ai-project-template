# Engineering standards

How code must be written on this project. Be prescriptive, not aspirational — "clean
code" means nothing; concrete rules with examples mean something. Claude pattern-matches
on examples better than on rules, so this file leans on good/bad pairs.

Most of this is reusable across clients. The stack-specific parts live elsewhere, in
three layers:

- **Here:** the invariant, in prose, plus an example. No rule names, no enforced numbers.
- **`stack.md`:** which tool enforces it, and where that tool is configured.
- **The config file:** the number, the severity, the actual gate.

A number that appears in this file is *indicative* — something to calibrate against
during the window before a linter exists, which on a new project is exactly when the
first feature gets written. It is never the enforced value. Don't copy it into a config
as a default; set that deliberately.

---

## The non-negotiable trio

Types, linter, formatter. Once wired, they run on every commit via pre-commit hooks and
again in CI, and that is not a matter of discipline — unformatted, untyped, or
lint-failing code cannot be committed.

> **Not wired yet on a fresh repo, and this file cannot tell you whether yours is.**
> The hooks and configs are generated when the stack is chosen — `docs/setup.md`.
> Until that's done, nothing above is enforced by anything — the rules still bind,
> but the only thing applying them is you. Check for the config files rather than assuming
> this heading means a gate exists.

---

## Functions and structure

- Functions do one thing. If you're describing it with "and", split it.
- Keep functions short. Past roughly 30 lines, go looking for a split. That number is a
  smell threshold, not a limit — see the note at the top. If there is no linter config
  yet, there is no enforced limit; do not infer one from this line.
- No deeply nested conditionals. Prefer early returns over nested `if`.
- No nested ternaries. One ternary is fine; a ternary inside a ternary is not.

## Naming

- Names say what the thing is or does, in full words. `bookedSlots`, not `bs`.
- Booleans read as questions: `isAvailable`, `hasPaid`, `canCancel`.
- Match the domain glossary. If the glossary says "booking", the code says `booking`,
  never `reservation` or `appt`.

## Errors

- Errors are typed, not stringly-typed. Don't `throw "something broke"`.
- Handle the error where you can do something useful about it; otherwise let it
  propagate. Never swallow an error silently (`catch {}` with nothing inside).
- User-facing error messages are plain and kind. No stack traces shown to users.

## Types

- **Never suppress the type system without recording why.** Two different things count,
  and it's worth knowing they're different:
  - a **silent cast** that widens or discards a type and leaves no trace the tooling can
    find later — `as any`, `cast(Any, x)`, an untyped escape into a dynamic value;
  - a **suppression directive**, which is a comment the checker can be told to police —
    `@ts-expect-error`, `# type: ignore[arg-type]`.

  Both need a comment giving the reason, and a linked open question when the honest reason
  is "we don't know yet." Prefer the directive over the silent cast where the language
  offers both: a directive can be required to name the error it suppresses, and flagged
  once it stops being necessary. A cast can't be — it looks like ordinary code forever.
- Validate external data at the boundary (network, storage, URL params) and give it a
  real type from that point inward. Don't trust the shape of anything from outside.

## Comments and docs

- Comment *why*, not *what*. The code says what; the comment explains the non-obvious
  reason.
- Every public/exported function has a short doc comment with at least one example of
  use where the usage isn't obvious.

## Tests

- Every feature ships with tests. A bug fix ships with a test that would have caught it.
- Test behavior, not implementation details.
- Tests use fake data only — never real client or user data.

---

## Good vs bad — examples are in TypeScript

The language is named in this heading on purpose. Concrete examples teach better than
pseudocode, so these stay concrete — but if this project isn't TypeScript, they show the
*rule*, not the syntax, and you should not pattern-match the code style from them.

Rewriting them in the project's language is an init task (see `docs/todo.md`). It is also
the init task most likely to get skipped, so until it's done, treat the heading as the
warning it is.

**Naming and early return**

Bad:
```
function p(u) {
  if (u) {
    if (u.paid) {
      return true
    }
  }
  return false
}
```

Good:
```
function hasCompletedPayment(user) {
  if (!user) return false
  return user.paid === true
}
```

**Error handling**

Bad:
```
try { syncBookings() } catch {}
```

Good:
```
try {
  syncBookings()
} catch (error) {
  logger.warn("booking sync failed, will retry", { error })
  scheduleRetry()
}
```

**Boundary validation** (pseudo — adapt to the chosen stack)

Bad: trust the data straight from local storage and use it.

Good: parse it through a schema validator, and on failure treat it as missing rather
than crashing — offline data can be stale or corrupted.

---

> Add project-specific rules below as they come up. When you find yourself correcting
> the same thing twice in review, write it down here so it's enforced going forward.
