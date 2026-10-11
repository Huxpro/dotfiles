#!/bin/bash
# Idempotent: safe to re-run. Anything it would overwrite is moved aside to
# <path>.pre-dotfiles.<timestamp> first. `install.sh --plan` only prints what
# would change.
#
# Two kinds of files:
#   link  - files a human authors. Symlinked, so edits land in this repo.
#   seed  - files an app rewrites by itself (Karabiner, Claude settings, Codex
#           config). Copied or merged once; a symlink would be replaced by the
#           app anyway and keep this repo permanently dirty.

set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
STAMP="$(date +%Y%m%d%H%M%S)"
PLAN=""
case "${1:-}" in
  --plan) PLAN=1 ;;
  "") ;;
  *) echo "usage: install.sh [--plan]" >&2; exit 2 ;;
esac
run() { [ -n "$PLAN" ] || "$@"; }

backup() {
  if [ -e "$1" ] || [ -L "$1" ]; then
    run mv "$1" "$1.pre-dotfiles.$STAMP"
    echo "  backup  $1 -> $1.pre-dotfiles.$STAMP"
  fi
}

link() {
  local src="$DOTFILES/$1" dst="$2"
  if [ "$(readlink "$dst" 2>/dev/null)" = "$src" ]; then
    return
  fi
  run mkdir -p "$(dirname "$dst")"
  backup "$dst"
  run ln -s "$src" "$dst"
  echo "  link    $dst -> $src"
}

seed() {
  local src="$DOTFILES/$1" dst="$2"
  # the app owns the live file from here on; never touch an existing one
  [ -e "$dst" ] && return
  run mkdir -p "$(dirname "$dst")"
  run cp "$src" "$dst"
  echo "  seed    $dst"
}

# bash
link bash/.bashrc ~/.bashrc

# zsh
link zsh/.zshrc ~/.zshrc
link zsh/.zshenv ~/.zshenv
link zsh/.zprofile ~/.zprofile
if [ -d ~/.oh-my-zsh ]; then
  link zsh/oh-my-zsh/themes/refined-lambda.zsh-theme ~/.oh-my-zsh/themes/refined-lambda.zsh-theme
else
  echo "  skip    oh-my-zsh theme (~/.oh-my-zsh missing, install it and re-run)"
fi

# vim
link vim/.vimrc ~/.vimrc
link vim/.vimrc ~/.ideavimrc

# neovim and coc
if [ -d ~/.config/nvim ]; then
  link nvim/init.vim ~/.config/nvim/init.vim
  link nvim/coc-settings.json ~/.config/nvim/coc-settings.json
else
  # fallback to vim
  link nvim/coc-settings.json ~/.vim/coc-settings.json
fi

# spacemacs
link emacs/.spacemacs ~/.spacemacs

# git
# ~/.gitconfig includes ~/.gitconfig.local (machine-local, never tracked) and,
# for repos under ~/byted/, ~/.gitconfig-bytedance. See NEW_MAC.md phase 2.
link git/.gitconfig ~/.gitconfig
link git/.gitignore ~/.gitignore
link git/.gitattributes ~/.gitattributes
run mkdir -p ~/github ~/byted

# karabiner
seed karabiner/karabiner.json ~/.config/karabiner/karabiner.json

# claude code
link claude/CLAUDE.md ~/.claude/CLAUDE.md
for f in "$DOTFILES"/claude/commands/*.md; do
  [ -e "$f" ] || continue
  link "claude/commands/$(basename "$f")" ~/.claude/commands/"$(basename "$f")"
done
for d in "$DOTFILES"/claude/skills/*/; do
  [ -d "$d" ] || continue
  link "claude/skills/$(basename "$d")" ~/.claude/skills/"$(basename "$d")"
done
# settings.json: keys in settings.base.json win, every other key (hooks and
# status line injected by apps, etc.) is preserved.
run mkdir -p ~/.claude
python3 -I - "$DOTFILES/claude/settings.base.json" ~/.claude/settings.json "$PLAN" <<'PY'
import json, os, sys
base_path, dst, plan = sys.argv[1:4]
base = json.load(open(base_path))
cur = json.load(open(dst)) if os.path.exists(dst) else {}
def merge(a, b):
    for k, v in b.items():
        if isinstance(v, dict) and isinstance(a.get(k), dict):
            merge(a[k], v)
        else:
            a[k] = v
    return a
new = merge(json.loads(json.dumps(cur)), base)
if new != cur:
    print("  merge   %s <- claude/settings.base.json" % dst)
if new != cur and not plan:
    tmp = dst + ".tmp"
    with open(tmp, "w") as f:
        json.dump(new, f, indent=2, ensure_ascii=False)
        f.write("\n")
    os.chmod(tmp, 0o600)
    os.replace(tmp, dst)
PY

# codex
seed codex/config.base.toml ~/.codex/config.toml

[ -n "$PLAN" ] && echo "plan only, nothing changed." || echo "done."
