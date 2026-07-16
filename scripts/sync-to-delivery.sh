#!/usr/bin/env bash
#
# sync-to-delivery.sh — copy ONLY allowlisted paths into the client delivery repo.
#
# Allowlist, not blocklist: anything not named below stays OUT of the client repo by
# default. That's the safe direction to fail — a file you forgot to categorise never
# reaches the client.
#
# Usage:  scripts/sync-to-delivery.sh /path/to/delivery-repo
#
# This copies current state only. It does NOT carry git history across — the delivery
# repo keeps its own clean history (see docs/handoff.md).

set -euo pipefail

DELIVERY_REPO="${1:-}"

if [[ -z "$DELIVERY_REPO" ]]; then
  echo "Usage: $0 /path/to/delivery-repo" >&2
  exit 1
fi

if [[ ! -d "$DELIVERY_REPO/.git" ]]; then
  echo "Error: '$DELIVERY_REPO' is not a git repo. Create the delivery repo first" >&2
  echo "(fresh 'git init' — do NOT clone this working repo; see docs/handoff.md)." >&2
  exit 1
fi

# Resolve the working repo root (this script lives in <root>/scripts/).
SRC_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# ---------------------------------------------------------------------------
# ALLOWLIST — edit per project. Only these paths are delivered.
# Keeper docs are authored delivery-ready, so they ship as-is.
# ---------------------------------------------------------------------------
ALLOWLIST=(
  "src"
  "README.md"
  # Keeper docs — uncomment / adjust once these exist and are cleaned for the client:
  # ".ai/client/glossary.md"
  # ".ai/engineering/architecture.md"
  # ".ai/engineering/adr"
)

echo "Syncing from: $SRC_ROOT"
echo "Delivering to: $DELIVERY_REPO"
echo

for path in "${ALLOWLIST[@]}"; do
  src="$SRC_ROOT/$path"
  if [[ ! -e "$src" ]]; then
    echo "  skip (not found): $path"
    continue
  fi
  dest="$DELIVERY_REPO/$path"

  if command -v rsync >/dev/null 2>&1; then
    # Preferred: --delete keeps the delivery copy in sync (removes files deleted on
    # our side), scoped to each allowlisted path only.
    if [[ -d "$src" ]]; then
      mkdir -p "$dest"
      rsync -a --delete "$src"/ "$dest"/
    else
      mkdir -p "$(dirname "$dest")"
      rsync -a "$src" "$dest"
    fi
  else
    # Fallback when rsync isn't installed: fresh copy (replace dest each run so
    # deletions on our side propagate).
    if [[ -d "$src" ]]; then
      rm -rf "$dest"
      mkdir -p "$dest"
      cp -R "$src"/. "$dest"/
    else
      mkdir -p "$(dirname "$dest")"
      cp "$src" "$dest"
    fi
  fi
  echo "  synced: $path"
done

echo
echo "Done. Now, in the delivery repo:"
echo "  1. Review the diff:            git -C '$DELIVERY_REPO' status && git -C '$DELIVERY_REPO' diff"
echo "  2. Confirm NO internal files:  git -C '$DELIVERY_REPO' ls-files | grep -E '\\.ai/|decisions-log|open-questions|todo' && echo 'STOP: internal files present' || echo 'clean'"
echo "  3. Commit with a clean message."
