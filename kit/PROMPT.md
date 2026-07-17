# The portable handoff prompt

No install needed. Paste this at the end of any session you want to resume later.
Works in Claude Code out of the box, and in other harnesses (Cursor, Codex, etc.)
as long as the agent can read and write files in your home directory. For the
automated version, install the skill instead (see START-HERE).

```
Write a LEAN session handoff so a fresh chat can resume without me re-explaining
anything — minimal tokens, no fluff.

Process first:
1. Mistake sweep (report only): list unresolved errors/broken state from this
   session. Ask me before fixing anything. Unfixed problems become Next step 1 or a
   Tried line.
2. Scope: include only commitments and state-changes from THIS session plus anything
   affecting the resumed task. Include ONLY what a fresh session cannot get from the
   repo, git, or project docs. Point to files, never paste their contents.
3. Save to ~/.claude/handoffs/<project-slug>.md (kebab-case project name; create the
   dir if needed). If a file with that slug exists for a DIFFERENT project path,
   append a short suffix instead of overwriting. Same project: keep one .bak of the
   prior version. Never write the handoff into the repo.
4. Privacy: no secrets, tokens, credentials, auth URLs, customer data, or copied file
   contents — safe paths and redacted excerpts only.

Template (target ~30 lines; NEVER trim Tried/constraints to hit the target):
# Handoff — <project> — status: ready|blocked
timestamp+timezone / cwd / repo root / branch / HEAD commit / dirty counts (exact, from git)
RESUME RITUAL: compare repo root+branch+HEAD+dirty against live git status; report any
mismatch BEFORE changing files; rerun Evidence only if safe; state Goal/State/Next in
3 lines; start Next 1 in the same turn unless blocked.
## Goal — one line incl. what done looks like
## State — Done: ... / In progress: ... (exact stop point)
## Evidence — strongest verification after last material change: command, exit code, one-line result
## Runtime — only if non-default: servers/ports/venvs/background jobs. Else omit.
## Next — 1. concrete first action, OR the exact blocker/decision if blocked. 2..n ordered.
## Tried / constraints — "Tried X, observed Y, retry only if Z changes", one per line.
## Decisions — decision + one-line why
## Key files — path + symbol/line + short label. Never contents.
## Session-open items — from THIS session. "None" only after a real check.

Then confirm the saved path and print exactly:
Read ~/.claude/handoffs/<project-slug>.md and continue
```

Next session, paste the printed resume line. That's the whole loop.
