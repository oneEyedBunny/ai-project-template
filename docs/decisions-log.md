# Decisions log

A running, lightweight record of choices made during the build. Not every choice —
just the ones where someone might later ask "why did we do it that way?" For which
choices belong here and which get an ADR instead, see the test under "Architecture
Decision Records" in `.ai/engineering/architecture.md`.

This is also part of Claude's memory across sessions: the repo remembers what the chat
forgets. When you make a call mid-build, drop a line here.

Format: newest at the top.

## When a decision goes stale

Entries are append-only. Never edit or delete a past decision — the value of this log is that
it records what was believed at the time, which is exactly what someone wants to know when a
decision turns out badly.

When something changes, write a new entry at the top, then add one line to the top of the old
entry:

**Superseded 2026-03-14** — see the entry above.

If only part of it changed, say which part:

**Superseded in part, 2026-03-14** — cost figure only; the vendor caveat below still stands.

Being specific matters: a bare "Superseded" throws away whatever is still true in the old
entry, and someone will act on that later.

There is no status field on every entry. An entry is only written once the call is made, so a
status would read the same on all of them — and a field that always says the same thing stops
being read.

CI enforces this. `scripts/check-decisions-immutable.sh` fails any pull request that removes
a line from this file or from `.ai/engineering/adr/`. Adding the **Superseded** line passes;
rewording the entry under it does not. If you genuinely need to edit — a typo, or clearing
the placeholders below — put the `amend-decision` label on the PR.

---

## 2026-08-13 — Adversarial review: dispositions
**Decision:** An external adversarial review of this repo returned six findings. Four
fixed, one recorded as an open question, one rejected. Two further defects it missed were
found while verifying it and are also fixed.

**Fixed — documents that lied about the repo's own state.** These are the class the review
was right to lead with, because a reader cannot tell a false assertion from a true one:

- `standards.md` asserted that types, linter, and formatter run on every commit and that
  failing code "cannot be committed." None of that is wired on a fresh repo, and the file
  said so ten lines earlier in the stack-agnostic note — it contradicted itself on one
  page. Now states the pending condition explicitly.
- `definition-of-done.md` claimed high-risk work "was flagged and approved by a human
  before building (per the stop-list)" for five areas. The stop-list covers two of them.
  A reviewer ticking that box was certifying an approval that could not have happened.
- *(missed by the review)* The same file's "Linter passes / Formatter passes" boxes are
  unavailable rather than passing when no linter exists. Same defect, second location.
- *(missed by the review)* The same file's type rule still named `any` and "ignores" —
  TypeScript-only, after `standards.md` was made language-neutral. The identical drift
  T1 hit, in a file nobody re-checked.

**Fixed — the guard did not guard itself.** CI runs
`scripts/check-decisions-immutable.sh` from the pull request's own branch, so a PR can
delete a decision record and edit the script's `GUARDED` list in the same commit and pass.
Confirmed by executing it: exit 0 with an ADR line deleted. `.github/CODEOWNERS` now covers
`/.github/` and `/scripts/`.

Worth being precise about what this was and wasn't. The review called it silent; it isn't
— the script edit appears in the diff. It was *unblocked*, not hidden, and the fix is to
force someone to look rather than to detect anything new. Note also that this is the
coupling `architecture.md` already warned about ("the guard silently stops covering
them"): the repo documented that `GUARDED` was load-bearing and then left it unprotected,
which is a sharper failure than not knowing.

CODEOWNERS carries its own footgun, called out in the file and in `docs/handoff.md`: an
owner without write access to the repo blocks every PR touching those paths. On a template
that gets copied, a stale handle is worse than no file.

**Raised as an open question, not fixed.** The review argued that removing "add a new
dependency" from the stop-list was wrong because a manifest diff does not expose the
transitive tree. That engages the recorded reasoning fairly and identifies a real gap in
it — the earlier entry leaned on "reviewed at the PR via the manifest diff," which is
weaker than it sounded. It does not weigh the cost that split was buying: a stop-list that
fires on routine work trains people to route around all of it. Left as a policy question
in `docs/open-questions.md`, together with whether payments and the sync boundary belong
on the stop-list at all.

**Rejected.** The review argued the boundary-contract marker fails because "due at the
first boundary ADR, or at handoff" is a condition rather than a date, and that an agent
needs a date to parse. Rejected on two grounds. It does not engage the record: a
date-based trigger is rejected in `operating-rules.md` under "When a check earns its
place," because a check firing on elapsed time carries no information about whether
anything needs doing and trains dismissal. And its premise is wrong about the mechanism —
the obligation was deliberately placed in `adr/0001` so an agent meets it while writing
the ADR, rather than by remembering to consult `architecture.md`. The underlying worry
(an agent inventing structure) is real; a date does not address it and costs the thing
that does. Recorded so it is not re-raised as new.

---

## 2026-08-13 — Handoff is the second trigger for the boundary contract
**Decision:** Two triggers, not one. The ADR criterion fires at the decision moment;
handoff is the guaranteed backstop. The marker in `architecture.md` now reads "due at the
first boundary ADR, or at handoff, whichever comes first," and the standing checklist in
`docs/todo.md` carries the item.

**Why a second trigger.** The failure this addresses splits in two, and only one half is a
problem. If a project genuinely made no boundary decisions, the marker is *accurate* and
there is nothing to fix. The real case is the other one: boundaries got established
without anyone recognizing them as decisions, so no ADR fired. That is not a failure of
deferring — it is the ADR criterion not being self-firing. It depends on recognition, and
the person establishing a boundary by accident is the one least able to recognize it.

Handoff works as the backstop because the delivery model guarantees the event, the
checklist already runs at it, and it lands when someone is reviewing repo state rather
than mid-task.

**The two triggers write different artifacts, and this is the part worth keeping.** At the
ADR the contract is a *constraint* — the build is live and its job is to rule things out.
At handoff it is a *description* — the structure is already set, and a constraint written
then hands the successor a picture of the architecture we wish we'd built. Unstated, this
produces fiction, confidently. If a contract already exists at handoff, the pass is not
rewriting it: **annotate**, with a dated as-built block underneath the original.

Annotate over replace or side-by-side: replacing destroys the evidence that the code
drifted, which is precisely what a successor cannot reconstruct; two contracts side by side
leave them unable to tell which governs. Annotating reuses the supersession shape already
established in this log — never edit the original, add a marked line.

The as-built answer must be written even when it is "no divergence." Blank is
indistinguishable from clean, and this is the item most likely to be dropped under
delivery pressure, because recording mess reads as admitting it.

**Considered and rejected: a check on new top-level directories under `src/`.** It targets
the right gap — the moment structure is created by accident — and it fires on a change
rather than on time, so it passes that test. It fails the other one: directories are
created for many non-boundary reasons, the false-positive rate is high, and a noisy check
trains dismissal that generalizes to checks carrying real information. Recorded here so it
does not get re-proposed as fresh.

**Also rejected: a date-based nag.** It fires on elapsed time and so carries no information
about whether anything needs doing. Worse, it does not address the real case at all — the
blindness that stopped the ADR from firing produces a contract that ratifies whatever
accreted. The generalized rule from both rejections is now in `.ai/operating-rules.md`
under "When a check earns its place."

**What this does and does not buy.** It does not guarantee the contract gets written. It
guarantees that *not* writing it is a recorded choice by the time the repo leaves our
hands. Given every check available here is structural rather than semantic, that is the
honest maximum — consistent with the ceiling already stated in `operating-rules.md`.

**Recorded limitation, no action.** Both triggers assume a delivery event. A long-running
internal repo has neither: no handoff, and an ADR criterion that still depends on someone
recognizing a boundary. The gap is real, but it sits outside the case this template was
built for, so the fix belongs to whoever adapts the template for internal use rather than
here. The marker reading "or at handoff" is what makes that inherited assumption visible —
depending on it silently would be worse.

Two things that keep this cheap, recorded so they don't have to be re-derived. First, a
long-running internal project is the case where the ADR criterion is *most* likely to fire
on its own: more decisions accumulate, so more chances to cross a boundary threshold. The
missing backstop matters less there than the bare gap suggests. Second, that leaves the
both-triggers-silent scenario as a *small* internal project — which is also the scenario
where a contract matters least. Same shape as the split at the top of this entry: a marker
sitting indefinitely on a project that made no boundary decisions is accurate, not stale.
The gap is concentrated where its cost is close to zero, which is why no further mechanism
is the right answer rather than merely an affordable one.

---

## 2026-08-13 — Standards are stack-agnostic; boundary contract splits by kind
**Decision:** Three layers. `standards.md` holds the invariant and an example.
`stack.md` holds which tool enforces it and where that tool is configured. The config file
holds the number. `standards.md` keeps *indicative* numbers, explicitly marked as not the
enforced value.

The boundary contract splits in two, declared at different times:

- **The client/server seam is declared at init.** You know at repo creation whether there
  is a server side, and its violation ships a secret in a bundle — a security failure, not
  a design smell. It also gets a one-line reminder in `CLAUDE.md`'s non-negotiables.
- **The structural shape (layered, or feature/shared/ui) is deferred**, with the first ADR
  that trips the T6 criterion as the trigger, and a visible NOT YET DECLARED marker until
  then.

**Why:** The three-layer split assumed all three layers exist. On a new project none of
them do except prose, and that window — before stack selection — is exactly when the first
feature gets written. Hence indicative numbers: an agent given "split when it smells" has
nothing to calibrate against and will write a 90-line function. They are marked
non-enforced so the first project doesn't set its linter to 30 by default rather than by
choice.

On the boundary halves: declaring structure early is worse than declaring it late, and
asymmetrically. An agent that reads a contract *builds* it — `domain → application →
infrastructure` becomes four empty folders in a three-file app, reinforced by every file
after. Late structure is only late. The seam has no such downside, because it is knowable
at init and dangerous to omit.

Deferral needs a trigger or it never happens. Rather than invent one, this reuses the ADR
criterion already in `architecture.md`: that criterion can't be applied by someone who
doesn't know the boundaries, so the first ADR to trip it is necessarily the moment the
contract must exist.

**Noticed, not built.** Two things in this template now cannot be enforced until the stack
is chosen: pre-commit hooks, and the client/server seam. Both are named as pending rather
than left implicit — the seam has its own row in the `stack.md` enforcement table, left
visibly blank. If a third one appears, they should stop being scattered obligations and
become a single named list in `stack.md` ("enforcement that activates at init"). Two isn't
enough to justify the list; three is.

**Alternatives considered:** Keeping `standards.md` openly TypeScript — rejected, the
template has to serve a Python repo. Dropping numbers entirely — rejected, see above.
Naming per-rule IDs in `stack.md` as a maintained second rulebook — rejected; the table is
a pointer table, and only its *path* column is checkable. The tool-and-rule column is
convention and is labelled as such rather than left to look authoritative. Declaring the
whole boundary contract at init — rejected for the asymmetry above. Deferring all of it,
including the seam — rejected, that leaves the only security-relevant boundary undeclared
during the weeks it is cheapest to violate.

---

## 2026-08-13 — Stop-list co-change check: designed, deferred
**Decision:** Don't build a sync guard for the two stop-list copies yet. The design below
is settled. The trigger to build it is the next edit to the stop-list in either file.

**The design.** A co-change check: fail the pull request when the diff touches the
stop-list in `CLAUDE.md` and does *not* touch the stop-list in
`.ai/engineering/how-we-work-with-ai.md`. It does not verify that the two agree — nothing
at this price can; see "What an automated check can actually do" in
`.ai/operating-rules.md`. It removes "I didn't realize the other copy existed" as an
available excuse, which is the same job the `amend-decision` label does for decision
records.

Scoping needs sentinels — a pair of HTML comment markers around the stop-list in both
files, with the check asking whether any changed line falls between them. Whole-file
co-change would fire on every edit to `CLAUDE.md`, a small router file that gets touched
often, and a check that mostly cries wolf trains people to satisfy it reflexively. The
cost is two markers that have to stay in place.

Known hole, accepted: a token edit inside the sentinels satisfies the check and looks like
ordinary work in the diff. That is slightly worse than the `amend-decision` hole, where
the override is a named artifact a reviewer can interrogate.

**Why defer.** Both copies are aligned as of this entry, and the list changes roughly once
a year. A guard built today sits idle until the next edit, and idle enforcement is exactly
where sentinel markers rot — someone reformats a file, the markers go with it, and the
check silently stops covering anything. Building it at the moment of the next stop-list
edit puts the guard and its first real use in the same pull request.

**Alternatives considered:** Generating the plain-language copy from the canonical list —
rejected: a build step is a permanent tax on a docs repo, and generated beginner prose
reads like generated prose. Checking item count and a per-item slug across both files —
rejected, and this is the instructive one: the only drift we have a specimen of (the
dependency policy, same day) kept five items with identical identities and changed one
item's *scope*. A slug check passes it clean. Reaching for identity because identity is
cheap to check, then reasoning about drift in terms of what that check can see, is how you
end up guarding the wrong thing. Accepting the risk with no guard at all — defensible,
since the failure mode is over-caution rather than danger, but a teammate waved through a
stop once will start guessing about the rest.

---

## 2026-08-13 — Drift-hardening pass on the template docs
**Decision:** Eight changes aimed at rules that drift because they are stated twice, or
stated too vaguely to apply the same way twice. Two are substantive; the rest are
plumbing.

The first substantive one: **decision records are append-only, enforced in CI.**
`scripts/check-decisions-immutable.sh` fails any PR that removes a line from
`docs/decisions-log.md` or `.ai/engineering/adr/`. Supersede by adding a line, never by
editing the old text. The `amend-decision` PR label is the sanctioned override.

The second: **the stop-list now has exactly one authoritative home.** It existed in three
— `CLAUDE.md`, `.ai/engineering/how-we-work-with-ai.md`, and `.ai/persona.md` — and the
three had already diverged, within a single editing session. Now:

- `CLAUDE.md` is authoritative.
- `how-we-work-with-ai.md` keeps a plain-language copy, explicitly marked as *not*
  authoritative. It is a standalone onboarding doc for teammates new to AI coding, who
  are told to read it first; a bare pointer would send them into a file addressed to
  Claude. The copy is deliberate, and its risk is recorded in `docs/open-questions.md`.
- `persona.md` no longer enumerates the list at all. It describes the shape the items
  share, so there is nothing in it that can contradict `CLAUDE.md`.

What exposed the divergence was a smaller change: **the dependency policy split.** Adding
a new package is no longer a stop-list item — it is reviewed at the PR via the manifest
diff, weighed against the new selection rubric in `.ai/engineering/stack.md`. Only
*upgrading* an existing package needs sign-off, because a version bump changes behavior
in ways the diff does not show. Editing one copy of the stop-list made the other two
wrong, which is how the three-way duplication surfaced.

The rest: a concrete ADR-vs-log test (module boundary, dependency direction, or public
interface → ADR), a stated duplication convention (repeat across layers, never within a
file), removal of a duplicated no-secrets bullet, and six one-time repo setup steps in
`docs/handoff.md`.

**Why:** The template's value is that a rule means the same thing on session 30 as on
session 1. A rule stated in two places drifts when only one copy is updated; a rule
stated as a vague judgment call about how weighty a decision feels is re-judged every
time. Both were present. Enforcement that lives in CI rather than in prose is the part
that cannot be forgotten.

The stop-list is the highest-stakes list in the repo. Three copies meant three chances to
be wrong about when to stop, and the wrong copy is the one someone happens to read.

**Alternatives considered:** Leaving the append-only rule as prose only — rejected, it is
exactly the kind of rule that erodes silently. Blocking new dependencies as well as
upgrades — rejected, it made the stop-list fire constantly for routine work, which trains
people to route around the whole list. Collapsing the `how-we-work-with-ai.md` copy into a
pointer — rejected on audience grounds, see above; that file's whole premise is that you
can read it and nothing else.

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
