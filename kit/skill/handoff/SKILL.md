---
name: handoff
description: Use when the user says "create a handoff", "make a handoff", "wrap up the session", or wants to save this session so a fresh one can resume it without re-explaining. Writes a lean session checkpoint and prints the resume command.
---

# handoff — lean session checkpoint

Write the checkpoint a fresh (empty-context) session resumes from — without the user
re-explaining the project, and without flooding the new session's context.

The rule that makes it lean: include ONLY what a fresh session cannot get from the
repo, git history, or the project's own docs. Point to files; never paste their contents.

## Flow

1. **Mistake sweep (report, don't touch).** List unresolved errors or broken states
   from this session. Creating a handoff does NOT authorize code changes. If something
   looks quickly fixable, ASK the user: "found X, fix before handoff?" — only fix (and
   re-verify) on an explicit yes. Anything unfixed becomes Next step 1 or a Tried line.
2. **Scope to this session.** Include commitments made this session, state that changed
   this session, and anything affecting the resumed task. Do not import the project's
   whole backlog — link to wherever it lives instead.
3. **Capture the header** by running, from the project directory:
   `bash "${CLAUDE_SKILL_DIR}/scripts/handoff-meta.sh"`
   and paste its output into the header block. If `bash` is unavailable (e.g. native
   Windows without Git Bash), gather the same fields yourself with git: timestamp+tz,
   cwd, `git rev-parse --show-toplevel`, branch (or DETACHED), short HEAD, and
   staged/unstaged/untracked counts from `git status --porcelain`.
4. **Write the file** to `~/.claude/handoffs/<project-slug>.md` (kebab-case the project
   folder name; create the directory if absent). Collision check first: if a handoff
   with this slug already exists but its `cwd:` line is a DIFFERENT project path, do
   not touch it — use `<project-slug>-<first 6 chars of the sha256 of this project's
   absolute path>.md` instead. If it is the same project, rename the old file to
   `<project-slug>.bak.md` (keep one prior version), then write fresh — never append.
5. **Confirm the saved path and print the resume command** on its own line so it is
   easy to copy:
   `Read ~/.claude/handoffs/<project-slug>.md and continue`

## Template (target ~30 lines — but NEVER trim Tried/constraints to hit the target;
failed approaches are especially valuable because a fresh session cannot recover
them from the repo or git history)

```markdown
# Handoff — <project> — status: ready|blocked
<paste handoff-meta.sh output: timestamp/cwd/repo_root/branch/head/dirty>

RESUME RITUAL: compare repo_root+branch+head+dirty against live `git status`; report
any mismatch BEFORE changing files. Rerun Evidence only if the command is safe. Then
state Goal/State/Next in 3 lines and start Next 1 in the same turn unless blocked.

## Goal — one line, including what done looks like
## State — Done: ... / In progress: ... (exact stop point)
## Evidence — strongest verification after the last material change: command, exit
   code, one-line result (+ failure excerpt if it failed)
## Runtime — only if non-default: servers/ports running, virtualenvs, background jobs
## Next — 1. first action: a concrete command/edit, OR the exact blocker/decision
   needed if blocked (never a destructive command). 2..n ordered rest.
## Tried / constraints — "Tried X, observed Y, retry only if Z changes", one per line
## Decisions — decision + one-line why
## Key files — path + symbol/line + short relevance label. Paths only, never contents.
## Session-open items — agreed-unfinished from THIS session. "None" only after a real check.

Resume: Read ~/.claude/handoffs/<project-slug>.md and continue
```

## Privacy rule (applies to every section)

Never include secrets, tokens, credentials, private authentication URLs, customer
data, or copied file contents. Record safe paths and redacted error excerpts only.

## Known limits

- Two windows working the SAME repo need git worktrees; the header mismatch check
  detects collisions, it does not prevent them.
- Unsaved editor buffers and killed processes cannot be checkpointed; the Runtime
  line records what needs restarting.
- The header is a drift tripwire, not proof — if it mismatches, investigate before
  trusting anything in the file.
