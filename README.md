# AI-assisted project template

A reusable starting point for client software projects built with AI doing the coding
and a human directing. Clone this per client (or use it as a GitHub *template repository*
so each new project is one click). Most of the thinking is baked in — starting a project
is mostly filling in the blanks, not facing a blank page.

## Quick start for a new client

1. Use this template (or clone it) into a new **private** repo.
2. Fill in the client-specific files (the ones with fill-in prompts):
   - `.ai/client/context.md`, `.ai/client/glossary.md`, `.ai/client/constraints.md`
   - `.ai/engineering/stack.md`
   - You can paste each to Claude and answer conversationally — it writes the structured
     version back.
3. Tweak the reusable engineering files if needed (they usually stand as-is).
4. Once the stack is chosen, ask Claude to generate the matching config: linter,
   formatter, pre-commit hooks, and CI. (Deliberately left out until the stack exists —
   those files can't be generic.)
5. Enable branch protection and mark this as a template repo (see below).

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
