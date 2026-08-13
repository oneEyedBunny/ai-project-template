# AI-assisted project template

A reusable starting point for client software projects built with AI doing the coding
and a human directing. Clone this per client (or use it as a GitHub *template repository*
so each new project is one click). This project uses a combo of custom built files and [agent-skills](https://github.com/addyosmani/agent-skills). Template = the rules of *this* project. agent-skills = the steps of good engineering. The template constrains; the skills sequence.

## How this template works with agent-skills

**This template (the `.ai/` directory) owns context and rules — the WHAT and WHY.**
It carries the things that are specific to *us and this client*: the operating
persona and stop-list, the client context and domain glossary, our engineering
standards, our patterns, the handoff process. No general-purpose tool can supply
these, because they're ours. That includes the `specs/` folder and the glossary —
where a spec lives and what language it has to use.

**[agent-skills](https://github.com/addyosmani/agent-skills) owns
execution workflow — the HOW.** It's a pack of production-grade engineering
workflows the AI follows step by step. We use a focused subset of it (not the
whole pack) to cover the plan/build/verify/ship spine that this template
deliberately leaves thin. Those skills are installed into the AI agent, not
stored in this repo — so we always get their latest version, and credit stays
with their author.

### Which agent-skills we use, and for what

| Phase  | Skill (from agent-skills)     | What it enforces                                    |
| ------ | ----------------------------- | --------------------------------------------------- |
| Plan   | `spec-driven-development`     | Spec before code: specify → plan → tasks → implement, with assumptions surfaced as questions |
| Build  | `incremental-implementation`  | Thin vertical slices: implement → test → verify → commit, one at a time |
| Build  | `test-driven-development`     | Red-green-refactor; tests as proof, not afterthought |
| Verify | `debugging-and-error-recovery`| Disciplined triage when things break: reproduce → localize → fix → guard |
| Ship   | `git-workflow-and-versioning` | Atomic commits and the branch-and-PR flow our branch protection requires |

Everything else in agent-skills (its 24 skills total) is intentionally left out
for now. Its ADR and definition-of-done skills overlap with what this template
already provides; the rest can be added later if a project needs them.

`spec-driven-development` and `specs/` are not a duplicate pair: the folder is
where a spec lives and what shape it takes, the skill is the discipline of
writing one before code and turning it into tasks. Neither supplies the other.

## Quick start for a new client

1. [Use this template (or clone it) into a new **private** repo.](#getting-this-into-github)
2. Fill in the client-specific files (the ones with fill-in prompts):
   - `.ai/client/context.md`, `.ai/client/glossary.md`, `.ai/client/constraints.md`
   - `.ai/engineering/stack.md`
   - You can paste each to Claude and answer conversationally — it writes the structured
     version back.
3. Tweak the reusable engineering files if needed (they usually stand as-is).
4. Install the agent-skills we use for plan/build/verify/ship (pulled from
   [agent-skills](https://github.com/addyosmani/agent-skills), not stored in this repo).
   Run once per machine or project:

   ```bash
   npx skills add addyosmani/agent-skills --skill spec-driven-development
   npx skills add addyosmani/agent-skills --skill incremental-implementation
   npx skills add addyosmani/agent-skills --skill test-driven-development
   npx skills add addyosmani/agent-skills --skill debugging-and-error-recovery
   npx skills add addyosmani/agent-skills --skill git-workflow-and-versioning
   ```

   See "How this template works with agent-skills" for which skill covers which phase.

5. **Work through `docs/setup.md`.** Everything left is a setting or a generated config
   rather than a file that ships in the template — branch protection, the required check,
   the `amend-decision` label, `CODEOWNERS`, and the linter/formatter/hooks/CI once the
   stack is chosen. Steps 1–4 above fail loudly if you skip them; these fail silently,
   and several of them are what make this repo's stated guardrails actually true.


## What's here

```
CLAUDE.md                  Entry point Claude reads first: router + the stop-list
.ai/
  persona.md               How Claude operates (seniority, when to stop) [reusable]
  operating-rules.md       Workflow + definition of done [reusable]
  client/                  FILL IN per client
    context.md             Who the client is, how decisions get made
    glossary.md            Domain terms — the highest-leverage file
    constraints.md         Compliance, budget, hard limits
  engineering/
    standards.md           Prescriptive code rules with good/bad examples [reusable]
    patterns.md            Approved patterns + PWA offline rules [partly reusable]
    architecture.md        System design + ADR index [fill in]
    stack.md               Tools + versions + WHY [fill in]
    how-we-work-with-ai.md Plain-language guide for AI-beginner teammates [reusable]
    adr/                   Architecture Decision Records, one file each
  workflow/
    definition-of-done.md  The completion checklist [reusable]
    review-checklist.md    Self-review + adversarial second-LLM review [reusable]
specs/                     Feature specs, one folder per feature
  _template/spec.md        Copy this to start a new spec [reusable]
docs/
  decisions-log.md         Running record of mid-build choices
  open-questions.md        Blocked-on-a-human decisions (the translation queue)
  todo.md                  Work queue + STANDING handoff checklist
  setup.md                 Day-one GitHub settings that turn the guardrails on
  handoff.md               How the client takes ownership (access, operability)
scripts/
  check-decisions-immutable.sh  CI guard: decision records are append-only [reusable]
.github/
  workflows/
    decisions-immutable.yml  Runs that guard on every PR [reusable]
  CODEOWNERS               Review required on the enforcement files themselves
                           — update the handle per repo [reusable]
src/                       Application code
.gitignore                 Scoped to secrets + build artifacts (NOT the .ai/ files)
.env.example               Documents env vars without committing secrets
```

## The layers, briefly

Context is organized from most stable to most volatile, so you update the changing parts
without disturbing the settled ones:

- **Reusable** (teal): persona, operating rules, standards, review workflow — set once.
- **Per client** (fill in): client context, glossary, constraints, stack.
- **Living state**: decisions log, open questions, todo — updated every session.
- **Enforcement**: active today — gitignore, and CI enforcing that decision records are
  append-only. Pending a stack choice — linter, formatter, type-checker, pre-commit
  hooks, and test CI. `.ai/engineering/standards.md` describes rules in both groups, so
  check `docs/todo.md` (project init) for which are actually wired.

## Client handoff

**One repo, everything ships.** We build with AI and we say so — the `.ai/` context files
are part of the deliverable, not something to scrub before handover. They're how the next
maintainer picks the codebase up without re-deriving every decision.

That makes the risk **abandonment**, not exposure: a client who owns a repo they can't
actually run. So handoff is about access and operability — README that works, env vars
documented, accounts and secrets transferred, branch protection on. Reasoning in
`docs/handoff.md`; the checklist that can't be skipped is standing at the bottom of
`docs/todo.md`.

## GitHub settings (not files — do these by hand)

Branch protection, the required append-only check, the `amend-decision` label, `CODEOWNERS`,
and the pre-commit hooks are settings rather than files. The repo cannot turn them on for
itself, and nothing fails loudly if you skip them — it just quietly has no guardrails while
several files claim it does.

**The ordered sequence is `docs/setup.md`.** Deliberately the only copy: a summary here
would be a second version to drift, and this is the one place in the repo where a stale
instruction means a control that was never actually switched on.

## Getting this into GitHub

Create an empty private repo, then either drag the files into the web UI / GitHub
Desktop, or from the command line:

```bash
cd ai-project-template
git init
git add .
git commit -m "Initial template"
git branch -M master
git remote add origin <your-repo-url>
git push -u origin master
```

Then flip on "Template repository" in Settings.
