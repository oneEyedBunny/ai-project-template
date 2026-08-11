# AI-assisted project template

A reusable starting point for client software projects built with AI doing the coding
and a human directing. Clone this per client (or use it as a GitHub *template repository*
so each new project is one click). This project uses a combo of custom built files and [agent-skills](https://github.com/addyosmani/agent-skills). Template = the rules of *this* project. agent-skills = the steps of good engineering. The template constrains; the skills sequence.

## How this template works with agent-skills

**This template (the `.ai/` directory) owns context and rules — the WHAT and WHY.**
It carries the things that are specific to *us and this client*: the operating
persona and stop-list, the client context and domain glossary, our engineering
standards, our patterns, the handoff process. No general-purpose tool can supply
these, because they're ours. We lean on our own `specs/` folder and glossary for the spec-driven-development (SDD).

** [agent-skills](https://github.com/addyosmani/agent-skills) owns
execution workflow — the HOW.** It's a pack of production-grade engineering
workflows the AI follows step by step. We use a focused subset of it (not the
whole pack) to cover the build/verify/ship middle that this template
deliberately leaves thin. Those skills are installed into the AI agent, not
stored in this repo — so we always get their latest version, and credit stays
with their author.

### Which agent-skills we use, and for what

| Phase  | Skill (from agent-skills)     | What it enforces                                    |
| ------ | ----------------------------- | --------------------------------------------------- |
| Build  | `incremental-implementation`  | Thin vertical slices: implement → test → verify → commit, one at a time |
| Build  | `test-driven-development`     | Red-green-refactor; tests as proof, not afterthought |
| Verify | `debugging-and-error-recovery`| Disciplined triage when things break: reproduce → localize → fix → guard |
| Ship   | `git-workflow-and-versioning` | Atomic commits and the branch-and-PR flow our branch protection requires |

Everything else in agent-skills (its 24 skills total) is intentionally left out
for now. Its ADR, definition-of-done, and spec skills overlap with what this
template already provides; the rest can be added later if a project needs them.

## Quick start for a new client

1. Use this template (or clone it) into a new **private** repo.
2. Fill in the client-specific files (the ones with fill-in prompts):
   - `.ai/client/context.md`, `.ai/client/glossary.md`, `.ai/client/constraints.md`
   - `.ai/engineering/stack.md`
   - You can paste each to Claude and answer conversationally — it writes the structured
     version back.
3. Tweak the reusable engineering files if needed (they usually stand as-is).
4. Install the agent-skills we use for build/verify/ship (pulled from
   [agent-skills](https://github.com/addyosmani/agent-skills), not stored in this repo).
   Run once per machine or project:
```bash
   npx skills add addyosmani/agent-skills --skill incremental-implementation
   npx skills add addyosmani/agent-skills --skill test-driven-development
   npx skills add addyosmani/agent-skills --skill debugging-and-error-recovery
   npx skills add addyosmani/agent-skills --skill git-workflow-and-versioning
```
   See "How this template works with agent-skills" for which skill covers which phase.
5. Once the stack is chosen, ask Claude to generate the matching config: linter,
   formatter, pre-commit hooks, and CI. (Deliberately left out until the stack exists —
   those files can't be generic.)
6. Enable branch protection and mark this as a template repo (see below).



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
specs/                     Feature specs (spec-kit lives here)
docs/
  decisions-log.md         Running record of mid-build choices
  open-questions.md        Blocked-on-a-human decisions (the translation queue)
  todo.md                  Work queue + STANDING handoff checklist
  handoff.md               The two-repo client handoff process
scripts/
  sync-to-delivery.sh      Allowlist copy of deliverable files to the client repo
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
- **Enforcement**: gitignore now; linter/formatter/CI once the stack is chosen.

## Guardrails (especially for teammates new to AI coding)

Two kinds, and the automated ones matter most because they can't be forgotten:

- **Automated** (enforce themselves): formatter, linter, type-checker on pre-commit;
  tests + checks in CI; branch protection so nothing lands on `main` without a reviewed
  pull request. These get generated once the stack is set.
- **Written** (judgment that can't be automated): the stop-list in `CLAUDE.md`, the
  "you must understand what you commit" rule, and `how-we-work-with-ai.md`. Each rule
  has a *why* — people follow rules they understand and route around ones they don't.

## Client handoff

Internal working files never reach the client. This is handled by a **two-repo model**,
not by deleting files at the end: a private working repo (everything) and a delivery repo
in the client's GitHub org (only `src/`, a README, and cleaned keeper docs). Code flows to
the clean side at every milestone via `scripts/sync-to-delivery.sh`, so handoff is a
verification, not a scramble. Full process in `docs/handoff.md`; the checklist that can't
be skipped is standing at the bottom of `docs/todo.md`.

## GitHub settings (not files — do these by hand)

- **Branch protection** on `main`: Settings → Branches → require a pull request to merge.
- **Template repository**: Settings → check "Template repository" for the one-click
  "Use this template" button on new projects.

## Getting this into GitHub

Create an empty private repo, then either drag the files into the web UI / GitHub
Desktop, or from the command line:

```bash
cd ai-project-template
git init
git add .
git commit -m "Initial template"
git branch -M main
git remote add origin <your-repo-url>
git push -u origin main
```

Then flip on "Template repository" in Settings.
