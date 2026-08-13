#!/usr/bin/env bash
#
# check-decisions-immutable.sh — fail a pull request that rewrites history in the
# decision records.
#
# The rule lives in the header of docs/decisions-log.md: these files are append-only.
# A past decision records what was believed AT THE TIME, which is exactly what someone
# wants when a decision turns out badly. Superseding is done by adding — a new entry at
# the top, and a "Superseded" line on the old one — never by editing the old text.
#
# So the check is mechanical. Inside the guarded paths a pull request may add lines and
# add files. It may not remove a line, and it may not delete or rename a file.
#
# Note that "modify a line" is "remove a line" as far as git is concerned, which is the
# behaviour we want: rewording a past decision is exactly the thing being prevented.
#
# Usage:
#   bash scripts/check-decisions-immutable.sh
#
# Environment:
#   BASE_REF             The branch this PR targets. CI passes github.base_ref. When
#                        unset, falls back to the remote's default branch, so this is
#                        never tied to a hardcoded 'main' or 'master'.
#   ALLOW_DECISION_EDIT  "true" downgrades violations to warnings and exits 0. Wired to
#                        the 'amend-decision' PR label — for typo fixes and for the
#                        one-time cleanup of this template's placeholder entries.
#
# Exit codes:  0 = clean (or waived)   1 = violation   2 = could not run the check

set -euo pipefail

# Paths guarded by this check. Adjust per project if the records move.
GUARDED=(
  "docs/decisions-log.md"
  ".ai/engineering/adr"
)

# ---------------------------------------------------------------------------
# Resolve what to diff against
# ---------------------------------------------------------------------------

if [[ -z "${BASE_REF:-}" ]]; then
  BASE_REF="$(git symbolic-ref --short refs/remotes/origin/HEAD 2>/dev/null | sed 's#^origin/##' || true)"
fi

if [[ -z "${BASE_REF:-}" ]]; then
  echo "Error: BASE_REF is unset and the remote's default branch could not be found." >&2
  echo "Run as: BASE_REF=<branch> bash $0" >&2
  exit 2
fi

BASE_COMMIT=""
for ref in "origin/${BASE_REF}" "${BASE_REF}"; do
  if git rev-parse --verify --quiet "${ref}^{commit}" >/dev/null 2>&1; then
    BASE_COMMIT="$ref"
    break
  fi
done

# Shallow clone, or a base branch this clone has never seen — try to fetch just it.
if [[ -z "$BASE_COMMIT" ]]; then
  git fetch --no-tags origin "+refs/heads/${BASE_REF}:refs/remotes/origin/${BASE_REF}" >/dev/null 2>&1 || true
  if git rev-parse --verify --quiet "origin/${BASE_REF}^{commit}" >/dev/null 2>&1; then
    BASE_COMMIT="origin/${BASE_REF}"
  fi
fi

if [[ -z "$BASE_COMMIT" ]]; then
  echo "Error: could not resolve base branch '${BASE_REF}'." >&2
  echo "In CI, check that actions/checkout ran with fetch-depth: 0." >&2
  exit 2
fi

if ! MERGE_BASE="$(git merge-base "$BASE_COMMIT" HEAD)"; then
  echo "Error: no common ancestor between HEAD and ${BASE_COMMIT}." >&2
  exit 2
fi

# ---------------------------------------------------------------------------
# Inspect the guarded paths
# ---------------------------------------------------------------------------

# --no-renames on purpose: a rename should surface as a deletion of the old path so it
# trips the check. Renaming a decision record away is not an escape route.
violations=0
findings=()

while IFS=$'\t' read -r status path; do
  [[ -z "${status:-}" ]] && continue
  case "$status" in
    D)
      findings+=("deleted:            ${path}")
      violations=$((violations + 1))
      ;;
    M|T)
      removed="$(git diff --no-renames --numstat "$MERGE_BASE" HEAD -- "$path" | cut -f2)"
      if [[ "$removed" == "-" ]]; then
        findings+=("became binary:      ${path}")
        violations=$((violations + 1))
      elif [[ "${removed:-0}" -gt 0 ]]; then
        findings+=("${removed} line(s) removed:  ${path}")
        violations=$((violations + 1))
      fi
      ;;
    # A (added) is fine — new entries and new ADRs are the whole point.
  esac
done < <(git diff --no-renames --name-status "$MERGE_BASE" HEAD -- "${GUARDED[@]}")

if [[ "$violations" -eq 0 ]]; then
  echo "Decision records are append-only in this PR. (base: ${BASE_COMMIT})"
  exit 0
fi

echo
echo "Decision records were rewritten, not appended to:"
echo
for finding in "${findings[@]}"; do
  echo "  - ${finding}"
done
echo

if [[ "${ALLOW_DECISION_EDIT:-false}" == "true" ]]; then
  echo "WAIVED by the 'amend-decision' label. The edit above is going in on purpose —"
  echo "make sure a reviewer actually looked at it."
  exit 0
fi

cat <<'EOF'
These files are append-only. To change what a past decision says:

  1. Write a NEW entry at the top of docs/decisions-log.md (or a new ADR).
  2. Add ONE line to the top of the old entry, naming what changed:

       **Superseded 2026-03-14** — see the entry above.
       **Superseded in part, 2026-03-14** — cost figure only; the caveat below stands.

Adding that line passes this check. Editing the old text does not, and that is the
point: the log is worth reading precisely because it records what was believed then.

Genuinely need to edit (a typo, or clearing this template's placeholders)? Add the
'amend-decision' label to the PR and push again.
EOF

exit 1
