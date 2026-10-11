#!/bin/bash
# Run on the NEW machine: utils/unpack-private.sh ~/Downloads/dotfiles-private-*.tgz
#
# Never overwrites: a file that already exists is left alone and reported.
# Claude project memories are re-keyed when $HOME differs from the old machine.

set -euo pipefail

TGZ="${1:?usage: unpack-private.sh <dotfiles-private-*.tgz>}"
STAGE="$(mktemp -d)"
trap 'rm -rf "$STAGE"' EXIT
tar -xzf "$TGZ" -C "$STAGE"
B="$STAGE/dotfiles-private"
OLD_HOME="$(sed -n 's/^old_home=//p' "$B/MANIFEST")"

place() { # copy a file or directory unless the destination exists
  local src="$1" dst="$2"
  [ -e "$src" ] || return 0
  if [ -e "$dst" ]; then
    echo "  keep    $dst (already exists)"
    return 0
  fi
  mkdir -p "$(dirname "$dst")"
  cp -R "$src" "$dst"
  echo "  place   $dst"
}

for f in .gitconfig.local .gitconfig-bytedance .stCommitMsg .gittemplates; do
  place "$B/git/$f" "$HOME/$f"
done
# paths written into the local git config by tools on the old machine
if [ "$OLD_HOME" != "$HOME" ] && grep -q "$OLD_HOME" "$HOME/.gitconfig.local" 2>/dev/null; then
  echo "  NOTE    ~/.gitconfig.local still references $OLD_HOME, review it"
fi

mkdir -p "$HOME/.ssh" && chmod 700 "$HOME/.ssh"
place "$B/ssh/config" "$HOME/.ssh/config"
[ -f "$HOME/.ssh/config" ] && chmod 600 "$HOME/.ssh/config"

for root in github byted; do
  for f in .envrc .npmrc; do
    place "$B/roots/$root/$f" "$HOME/$root/$f"
  done
done

place "$B/claude-home/AGENTS.md" "$HOME/.claude/AGENTS.md"
place "$B/claude-home/MEMORY.md" "$HOME/.claude/MEMORY.md"
place "$B/claude-home/memory" "$HOME/.claude/memory"

# Claude keys a project by its absolute path with every non-alphanumeric
# character turned into "-".
key_of() { printf '%s' "$1" | sed 's/[^A-Za-z0-9]/-/g'; }
old_key="$(key_of "$OLD_HOME")"
new_key="$(key_of "$HOME")"
for d in "$B"/claude-projects/*/; do
  [ -d "$d" ] || continue
  key="$(basename "$d")"
  case "$key" in "$old_key"*) key="$new_key${key#"$old_key"}" ;; esac
  place "$d/memory" "$HOME/.claude/projects/$key/memory"
done

for d in "$B"/agents/skills-local/*/; do
  [ -d "$d" ] || continue
  place "$d" "$HOME/.agents/skills/$(basename "$d")"
done

place "$B/agents/skills.internal.tsv" "$HOME/.dotfiles-private/skills.internal.tsv"
for f in "$B"/notes/*; do
  [ -e "$f" ] && place "$f" "$HOME/.dotfiles-private/$(basename "$f")"
done

echo "done. Read ~/.dotfiles-private/NOTES.md next."
