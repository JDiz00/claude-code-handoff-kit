#!/usr/bin/env bash
# handoff-meta: deterministic state header for the handoff skill.
# Prints drift-tripwire fields for the handoff header:
# timestamp+tz, cwd, repo root, branch/detached, HEAD, dirty counts. Read-only.
set -uo pipefail
echo "timestamp: $(date '+%Y-%m-%d %H:%M %Z')"
echo "cwd: $PWD"
if git rev-parse --show-toplevel >/dev/null 2>&1; then
    echo "repo_root: $(git rev-parse --show-toplevel)"
    br=$(git symbolic-ref --short HEAD 2>/dev/null || echo "DETACHED")
    echo "branch: $br"
    echo "head: $(git rev-parse --short HEAD 2>/dev/null || echo none)"
    s=$(git status --porcelain 2>/dev/null)
    staged=$(grep -c '^[MADRCTU]' <<<"$s"); unstaged=$(grep -c '^.[MDTU]' <<<"$s"); untracked=$(grep -c '^??' <<<"$s")
    echo "dirty: staged=$staged unstaged=$unstaged untracked=$untracked"
else
    echo "repo_root: non-git"
fi
