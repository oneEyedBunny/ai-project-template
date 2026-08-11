# Todo

Decided-but-not-yet-built work. This is the *execution* queue — no decisions pending
here (those live in `open-questions.md`).

> Recommendation: once the team is comfortable, move this to GitHub Issues. Issues are
> shared, link to pull requests, and fit the branch-per-task workflow better than a file.
> Keep this file only as a simple starting point, OR keep it just for the standing
> handoff checklist below, which doesn't map cleanly to a feature issue.

## In progress

## Up next

## Backlog

---

## STANDING: final client handoff checklist (DO NOT SKIP)

The failure mode this guards against is **abandonment** — the client owns a repo they
can't actually operate. It lives here permanently so it can't be forgotten. Work through
every box before handing over. See `docs/handoff.md` for the reasoning.

**Can they run it?**
- [ ] README covers: what the app is, how to run it locally, how to deploy it
- [ ] A person who has never seen the project followed the README start to finish and
      got it running — actually tested, not assumed
- [ ] `.env.example` lists every env var the app reads, with a note on where real
      values come from

**Do they own it?**
- [ ] Repo ownership transferred to the client's GitHub org (or their account)
- [ ] Their team's access confirmed working — someone on their side has pushed or
      opened a PR successfully
- [ ] Branch protection enabled on `main`
- [ ] Any third-party accounts we set up (hosting, DB, APIs, domains) are in their
      name or transferred, and billing points at them

**Can they maintain it?**
- [ ] Secrets rotated off anything tied to us; the client holds the current values
- [ ] `docs/decisions-log.md` and the ADRs explain the non-obvious choices
- [ ] `.ai/client/glossary.md` is current — it's the file that saves the next dev
- [ ] Open items are written down in `docs/open-questions.md`, not left verbal
- [ ] They know we built with AI, what `.ai/` is for, and how to keep using it
