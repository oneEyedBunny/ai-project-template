# Engineering standards

How code must be written on this project. Be prescriptive, not aspirational — "clean
code" means nothing; concrete rules with examples mean something. Claude pattern-matches
on examples better than on rules, so this file leans on good/bad pairs.

Most of this is reusable across clients. The stack-specific parts (which linter, which
formatter) live in `stack.md` and in the config files at the repo root.

---

## The non-negotiable trio (enforced automatically)

Types, linter, formatter run on every commit via pre-commit hooks, and again in CI.
This is not optional and not a matter of discipline — unformatted, untyped, or
lint-failing code cannot be committed. See the config files once the stack is chosen.

---

## Functions and structure

- Functions do one thing. If you're describing it with "and", split it.
- Keep functions short. If one grows past ~30 lines, that's a smell — look for a split.
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

- No escape hatches (`any`, `@ts-ignore`, equivalent) without a comment explaining why
  and, ideally, a linked open question.
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

## Good vs bad

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
