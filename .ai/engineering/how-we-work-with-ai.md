# How we work with AI on this project

Written for teammates who are new to using AI to write code. Plain language, ten-minute
read. The goal is simple: get the benefit of AI without the ways it goes wrong.

## The one thing to understand

AI writes code that *looks* confident and correct even when it's wrong. The danger isn't
messy code — the AI writes tidy-looking code. The danger is trusting something that's
subtly broken because it sounded sure. Your job is to stay the judge, not become a
rubber stamp.

## The golden rule

**If you can't explain, in plain English, what a piece of code does — it doesn't get
committed.** Not "the AI said it works." *You* understand it, or you ask until you do.
This one rule prevents most beginner disasters. It's completely fine to ask Claude
"explain this line by line like I'm new" — do it as often as you need.

## The stop-list (also in CLAUDE.md)

`CLAUDE.md` holds the authoritative copy of this list — if the two ever disagree, that
one wins and this one is the bug. It's repeated here in plainer language so you don't
have to read a file written for the AI.

Never let the AI do these on its own. Bring them to Ally first. Each has a reason:

1. **Auth / login code** — get it wrong and everyone's account is exposed.
2. **Anything that moves money** — charges, refunds, payouts, working out what someone
   gets billed. A mistake here takes real money off a real person, and getting it back
   is slow and embarrassing. Building screens *around* payments is fine; changing what
   charges whom is not.
3. **Database schema changes / migrations** — a wrong one can permanently lose the
   client's data, and it's hard to undo.
4. **Deciding what wins when offline changes collide** — two people edit the same thing,
   or a phone comes back online with stale edits. The rule for who wins is a stop; the
   ordinary feature work around it isn't. Get this wrong and data disappears quietly,
   with nothing to restore from.
5. **Upgrading a library we already use** — a version bump can change how it behaves in
   ways the diff doesn't show. Adding a *brand-new* library isn't on this list: propose
   it in the pull request and say why you picked that one.
6. **Real client or user data** — never paste it into the AI, into tests, or into logs.
   Use fake data.
7. **Anything secret** — API keys, passwords. These never go into the code or the chat.

Rules you understand are rules you'll follow. Rules you don't, you'll route around —
so if any of these don't make sense, ask why. The "why" matters more than the rule.

## How to actually work day to day

1. Pick up a task (a GitHub Issue).
2. Make a branch off `master` (the default branch). Never work directly on `master`.
3. Work with Claude to build it. Ask it to write tests too.
4. Run the tests. Read the code. Understand it. Ask about anything unclear.
5. Open a pull request. Ally reviews everything, at first.
6. Once the project's checks exist, they run on their own — formatting, types, tests —
   and if they fail, the code isn't ready. That's the safety net, not an insult.
   On a fresh repo they aren't wired yet; they get generated once the stack is chosen.
   Until then step 4 is the only thing checking, so look for the config files rather
   than assuming a green pull request means anything ran.

## When the AI and you disagree

If Claude pushes back on something, don't just override it, and don't just obey it.
Ask it to explain its reasoning, then use your judgment. The same goes when a second
AI reviews the first one's code — the point of disagreement is usually where the real
bug is hiding.

## Good habits

- Give context. Point Claude at the spec and the glossary before asking for a feature.
- Ask for small pieces you can understand, not giant chunks you can't.
- When Claude flags an open question, take it seriously — it's telling you a human
  decision is needed. Those go in `docs/open-questions.md`.
- It's okay to not know things. Asking is the job, not a failure.
