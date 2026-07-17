# Handoff policy — the rules that make it work

One page. These rules are why the template works; skip them and you have a
note-taking habit, not a resume system.

## 1. When to hand off

- End of any session you'll continue later — even "just an hour later".
- Before context gets long enough to auto-summarize. The summary keeps decisions
  but drops failed approaches; the handoff keeps both.
- NOT for two windows working the same repo at the same time — that's what git
  worktrees are for. The handoff's header will catch the collision, but it can't
  prevent two sessions overwriting each other's work.

## 2. Mistake sweep — report, don't touch

Before writing the handoff, the agent lists anything still broken from the session.
Creating a handoff never authorizes code changes. If something looks quickly
fixable, the agent asks first; on a yes it fixes AND re-verifies. Anything unfixed
becomes Next step 1 or a Tried line — never silently dropped.

## 3. Never trim Tried / constraints

The target is ~30 lines, but the length budget never comes out of the
Tried/constraints section. Failed approaches are especially valuable because a
fresh session cannot recover them from the repo or git history — trim them and the
next session cheerfully re-runs your dead ends.

## 4. The resume ritual — trust nothing, verify first

"Read the file and continue" is blind trust. The handoff file itself instructs the
resuming session to: compare the header (branch, HEAD, dirty counts) against live
`git status`, report any mismatch BEFORE changing files, restate Goal/State/Next in
three lines, then start Next step 1 in the same turn. The header is a drift
tripwire, not proof — matching counts can still hide different states, but a
mismatch reliably means STOP and investigate.

## 5. Lean means pointers, not pastes

Include only what a fresh session cannot get from the repo, git history, or project
docs. Paths and line references, never file contents. Pasting history back in
buries the signal and burns the new session's context.

## 6. Privacy — applies to every section

Never include secrets, tokens, credentials, private authentication URLs, customer
data, or copied file contents. Safe paths and redacted error excerpts only. The
handoff lives in `~/.claude/handoffs/`, outside your repo, so it never lands in a
commit — keep it that way.
