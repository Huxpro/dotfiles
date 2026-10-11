#!/bin/bash
# Run on the OLD machine. Collects the things that must not live in this public
# repo (work identity, internal hosts, agent memories) into one tarball to hand
# over out-of-band (AirDrop / USB). Restore with utils/unpack-private.sh.
#
# Deliberately NOT included, re-create them on the new machine instead:
#   SSH private keys, ~/.npmrc, gh / claude / codex / lark-cli logins, cookies.
#
# Hand-written private notes go in ~/.dotfiles-private/ and are bundled as-is.

set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OUT="${1:-$HOME/dotfiles-private-$(date +%Y%m%d).tgz}"
STAGE="$(mktemp -d)"
trap 'rm -rf "$STAGE"' EXIT
B="$STAGE/dotfiles-private"
mkdir -p "$B"/{git,ssh,roots,claude-home,claude-projects,agents/skills-local,notes}

echo "old_home=$HOME" >"$B/MANIFEST"
echo "packed_at=$(date +%Y-%m-%dT%H:%M:%S%z)" >>"$B/MANIFEST"

# git: machine-local + work identity
for f in .gitconfig.local .gitconfig-bytedance .stCommitMsg; do
  [ -f "$HOME/$f" ] && cp "$HOME/$f" "$B/git/$f"
done
[ -d "$HOME/.gittemplates" ] && cp -R "$HOME/.gittemplates" "$B/git/.gittemplates"

# ssh: host aliases only, never keys
[ -f "$HOME/.ssh/config" ] && cp "$HOME/.ssh/config" "$B/ssh/config"

# per-root npm registry / direnv config, with credential lines removed
for root in github byted; do
  for f in .envrc .npmrc; do
    [ -f "$HOME/$root/$f" ] || continue
    mkdir -p "$B/roots/$root"
    grep -vE '(_authToken|_auth|_password|TOKEN[A-Za-z_]*)[[:space:]]*=' "$HOME/$root/$f" >"$B/roots/$root/$f" || true
  done
done

# claude: user-level instructions that mention internal systems, and memories
for f in AGENTS.md MEMORY.md; do
  [ -f "$HOME/.claude/$f" ] && cp "$HOME/.claude/$f" "$B/claude-home/$f"
done
[ -d "$HOME/.claude/memory" ] && cp -R "$HOME/.claude/memory" "$B/claude-home/memory"
for d in "$HOME"/.claude/projects/*/memory; do
  [ -n "$(ls -A "$d" 2>/dev/null)" ] || continue
  key="$(basename "$(dirname "$d")")"
  case "$key" in *-conductor-workspaces-*) continue ;; esac # throwaway workspace paths
  mkdir -p "$B/claude-projects/$key"
  cp -R "$d" "$B/claude-projects/$key/memory"
done

# skills: internal sources + skills that exist only on disk (not in the lock)
"$DOTFILES/agents/skills.sh" dump-internal "$B/agents/skills.internal.tsv"
python3 -I - "$HOME/.agents/.skill-lock.json" "$HOME/.agents/skills" <<'PY' | while read -r name; do
import json, os, sys
locked = set(json.load(open(sys.argv[1]))["skills"])
for name in sorted(os.listdir(sys.argv[2])):
    if name not in locked and os.path.isdir(os.path.join(sys.argv[2], name)):
        print(name)
PY
  # skills tracked in the public repo are already covered
  [ -d "$DOTFILES/claude/skills/$name" ] || cp -R "$HOME/.agents/skills/$name" "$B/agents/skills-local/$name"
done

# repo list: what was cloned where, most recently touched first
{
  for root in "$HOME/github" "$HOME/byted"; do
    echo "## ${root/#$HOME/~}"
    echo
    for d in "$root"/*/; do
      [ -d "$d/.git" ] || continue # skips worktrees, their .git is a file
      url="$(git -C "$d" remote get-url origin 2>/dev/null || true)"
      [ -n "$url" ] || continue
      up="$(git -C "$d" remote get-url upstream 2>/dev/null || true)"
      echo "$(git -C "$d" log -1 --format=%cs 2>/dev/null || echo 0000-00-00) | $(basename "$d") | $url${up:+ | upstream: $up}"
    done | sort -r
    echo
  done
} >"$B/notes/REPOS.md"

[ -d "$HOME/.dotfiles-private" ] && cp -R "$HOME/.dotfiles-private/." "$B/notes/"

find "$B" -name .DS_Store -delete

# refuse to ship anything that looks like a credential
if hits="$(grep -rIlE '(ghp_|gho_|github_pat_|(^|[^A-Za-z0-9-])sk-[A-Za-z0-9_-]{20}|xox[bap]-|NPM_TOKEN=|-----BEGIN [A-Z ]*PRIVATE KEY|_authToken|Bearer [A-Za-z0-9._-]{20})' "$B")"; then
  echo "Possible secrets found, aborting. Clean these up first:" >&2
  echo "$hits" | sed "s|^$B/|  |" >&2
  exit 1
fi

tar -czf "$OUT" -C "$STAGE" dotfiles-private
chmod 600 "$OUT"
echo "wrote $OUT ($(du -h "$OUT" | cut -f1), $(tar -tzf "$OUT" | grep -vc '/$') files)"
