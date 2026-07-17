# Compatibility & known limits

Version 1.0.0. Tested against Claude Code 2.1.163 on Linux.

## Supported

| Environment | Status |
|---|---|
| Claude Code on macOS / Linux | Supported |
| Claude Code on Windows via WSL or Git Bash | Supported |
| Claude Code on native Windows (PowerShell only) | Works with graceful fallback — the skill tells the agent to gather the header fields with git directly when `bash` is missing |
| Cursor, Codex, other harnesses | Portable prompt only (`PROMPT.md`), as long as the agent can read and write files in your home directory |
| Non-git projects | Supported — header records `repo_root: non-git`; the git-verification half of the resume ritual is skipped |
| Brand-new repos (git init, no commits yet) | Supported — branch records as unborn/none |
| Detached HEAD | Supported — branch records as `DETACHED` |

## Install levels

The documented install is personal-level: `~/.claude/skills/handoff/`. A
project-level install (`.claude/skills/handoff/` inside a repo) also works but
shares the skill with everyone on the repo — make that choice deliberately.

If you already have a `/handoff` command or skill, installing this one will shadow
or collide with it. Check first: look in `~/.claude/skills/` and
`~/.claude/commands/`. Uninstall = delete the `handoff` folder; nothing else is
touched.

## Known limits (honest ones)

- **The header is a drift tripwire, not proof.** Equal dirty counts can hide
  different file states. A mismatch reliably means stop and investigate; a match
  is strong-but-not-perfect evidence you're where you left off.
- **Two windows, same repo:** use git worktrees. The tripwire detects collisions
  after the fact; it does not prevent them.
- **Unsaved editor buffers and killed processes** cannot be checkpointed. The
  Runtime line records what needs restarting; it can't restart it for you.
- **The resume ritual is an instruction, not magic.** The fresh session verifies
  state because the file tells it to. Agents follow it reliably, but a heavily
  customized setup that suppresses instructions can skip it.

## Privacy

Everything runs locally. No telemetry, no network calls, nothing phones home. The
helper script is read-only (`git status`, `git rev-parse` — it changes nothing).
