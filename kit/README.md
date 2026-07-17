# Claude Code Handoff Kit

Close a session today, resume it tomorrow without re-explaining your project.

Every fresh Claude Code session starts at zero. Summaries and `/compact` keep your
decisions but can quietly drop the most expensive thing you learned: the approaches
that DIDN'T work. This kit writes a lean, verified checkpoint at the end of a session and
teaches the next session to distrust it until it checks your repo's live state.

## What's inside

| File | What it is |
|---|---|
| `START-HERE.html` | Open this first: install, use, resume, uninstall |
| `PROMPT.md` | Zero-install paste prompt (works in any harness that can write files) |
| `skill/handoff/` | Self-contained Claude Code skill, invoked with `/handoff` |
| `docs/POLICY.md` | The rules that make handoffs actually work |
| `docs/COMPATIBILITY.md` | What's supported, what's not, known limits |
| `docs/EXAMPLE-HANDOFF.md` | A real generated handoff, so you see the output first |

## Quick start (60 seconds)

**No install:** copy the prompt from `PROMPT.md`, paste it at the end of a session.
It writes `~/.claude/handoffs/<project>.md` and prints a one-line resume command.

**Skill install:** copy `skill/handoff/` to `~/.claude/skills/handoff/`, then end any
session with `/handoff`. Next session, paste the printed resume line:

```
Read ~/.claude/handoffs/<project>.md and continue
```

The fresh session compares your repo state (branch, HEAD, dirty counts) against the
file and reports any drift it finds BEFORE it edits a thing.

## Why lean

A handoff is not a transcript. It records only what a fresh session cannot get from
the repo, git history, or your docs: the goal, the exact stop point, verification
evidence, the next action, and the dead ends. Everything else is a pointer, never a
paste. Around 30 lines resumes faster than 300.

## Privacy

The skill's rules bar secrets, tokens, credentials, private URLs, customer data, and
copied file contents from every handoff. Safe paths and redacted excerpts only. The
kit adds no telemetry and makes no network calls of its own.

## Get updates

This kit is free. Grab it from Gumroad to get fixes and new versions by email:
**https://expressive446.gumroad.com/l/handoff-kit?utm_source=kit&utm_medium=readme**

## License

MIT, see `LICENSE`.
