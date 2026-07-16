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

Never let the AI do these on its own. Bring them to Ally first. Each has a reason:

1. **Auth / login code** — get it wrong and everyone's account is exposed.
2. **Database schema changes / migrations** — a wrong one can permanently lose the
   client's data, and it's hard to undo.
3. **Adding a new dependency / library** — each one is new risk; we decide together.
4. **Real client or user data** — never paste it into the AI, into tests, or into logs.
   Use fake data.
5. **Anything secret** — API keys, passwords. These never go into the code or the chat.

Rules you understand are rules you'll follow. Rules you don't, you'll route around —
so if any of these don't make sense, ask why. The "why" matters more than the rule.

## How to actually work day to day

1. Pick up a task (a GitHub Issue).
2. Make a branch. Never work directly on `main`.
3. Work with Claude to build it. Ask it to write tests too.
4. Run the tests. Read the code. Understand it. Ask about anything unclear.
5. Open a pull request. Ally reviews everything, at first.
6. The automated checks (formatting, types, tests) run on their own — if they fail,
   the code isn't ready. That's the safety net, not an insult.

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
