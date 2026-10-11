#!/bin/bash
# Checks a machine set up from NEW_MAC_AGENT.md. Read-only apart from two throwaway
# git repos used to probe the per-directory identity. Exit code 1 on any FAIL.
#
# Expected values are derived from the config itself rather than written here,
# so this file stays free of work-side details.

set -uo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
fail=0
pass() { echo "PASS  $1"; }
flunk() { echo "FAIL  $1"; fail=1; }
check() { # description, command...
  local what="$1"
  shift
  if "$@" >/dev/null 2>&1; then pass "$what"; else flunk "$what"; fi
}

echo "== tools"
for cmd in git gh rg fzf tmux direnv node npm pnpm bun uv claude codex; do
  check "$cmd on PATH" zsh -ic "command -v $cmd"
done

echo "== shell"
for f in .zshrc .zprofile .zshenv; do
  check "~/$f links into this repo" test "$(readlink "$HOME/$f")" = "$DOTFILES/zsh/$f"
done
for plugin in zsh-completions zsh-syntax-highlighting; do
  check "oh-my-zsh plugin $plugin" test -d "$HOME/.oh-my-zsh/custom/plugins/$plugin"
done
out="$(zsh -ic 'type cc ccx cx tt >/dev/null && echo ok' 2>&1)"
# without a tty zsh prints harmless zle/iTerm noise, so look for real breakage
if [ "${out##*$'\n'}" != ok ] && [[ "$out" != *ok ]] || grep -qE 'not found|no such file' <<<"$out"; then
  flunk "interactive zsh starts clean: $out"
else
  pass "interactive zsh starts clean"
fi
check "tr is the real tr" zsh -ic '[[ "$(whence -w tr)" == "tr: command" ]]'

echo "== git identities"
check "user.name is set" git config user.name
personal="$(mktemp -d "$HOME/github/.verify.XXXXXX")"
work="$(mktemp -d "$HOME/byted/.verify.XXXXXX")"
trap 'rm -rf "$personal" "$work"' EXIT
git init -q "$personal" && git init -q "$work"
p_email="$(git -C "$personal" config user.email)"
w_email="$(git -C "$work" config user.email)"
want_p="$(git config --file "$DOTFILES/git/.gitconfig" user.email)"
want_w="$(git config --file "$HOME/.gitconfig-bytedance" user.email 2>/dev/null)"
[ -n "$p_email" ] && [ "$p_email" = "$want_p" ] && pass "~/github commits as $p_email" || flunk "~/github email is '$p_email', want '$want_p'"
[ -n "$w_email" ] && [ "$w_email" = "$want_w" ] && [ "$w_email" != "$p_email" ] && pass "~/byted commits as $w_email" || flunk "~/byted email is '$w_email', want '$want_w' (from ~/.gitconfig-bytedance)"
hooks="$(git config core.hooksPath || true)"
[ -z "$hooks" ] || [ -d "$hooks" ] && pass "core.hooksPath exists or is unset" || flunk "core.hooksPath points to missing $hooks"
check "gh is logged in" gh auth status

echo "== npm registry per root"
for root in github byted; do
  [ -f "$HOME/$root/.envrc" ] || [ -f "$HOME/$root/.npmrc" ] || continue
  reg="$(cd "$HOME/$root" && direnv exec . npm config get registry 2>/dev/null)"
  want="$(sed -n 's/^registry=//p' "$HOME/$root/.npmrc" 2>/dev/null)"
  [ -n "$reg" ] && [ "$reg" = "${want:-$reg}" ] && pass "~/$root uses $reg" || flunk "~/$root registry is '$reg', want '$want' (direnv allow?)"
done

echo "== agents"
check "~/.claude/CLAUDE.md links into this repo" test "$(readlink "$HOME/.claude/CLAUDE.md")" = "$DOTFILES/claude/CLAUDE.md"
check "claude settings carry the base keys" python3 -I -c '
import json, os, sys
base = json.load(open(sys.argv[1])); cur = json.load(open(os.path.expanduser("~/.claude/settings.json")))
sys.exit(0 if all(cur.get(k) == v for k, v in base.items()) else 1)' "$DOTFILES/claude/settings.base.json"
check "~/.codex/config.toml exists" test -f "$HOME/.codex/config.toml"
want_skills=0 have_skills=0
while IFS=$'\t' read -r _ _ skills; do
  for s in $skills; do
    want_skills=$((want_skills + 1))
    [ -d "$HOME/.agents/skills/$s" ] && have_skills=$((have_skills + 1))
  done
done <"$DOTFILES/agents/skills.tsv"
[ "$have_skills" = "$want_skills" ] && pass "public skills installed ($have_skills/$want_skills)" || flunk "public skills installed ($have_skills/$want_skills)"
check "claude MCP lynx-docs configured" zsh -ic 'claude mcp get lynx-docs'

echo "== repo"
dirty="$(git -C "$DOTFILES" status --short)"
[ -z "$dirty" ] && pass "dotfiles repo is clean" || { echo "NOTE  dotfiles repo has local changes:"; echo "$dirty" | sed 's/^/        /'; }

[ "$fail" = 0 ] && echo "all checks passed" || echo "some checks FAILED"
echo "Still manual: SSH to the work git host, codex/lark-cli logins, Xcode, GUI app settings."
exit "$fail"
