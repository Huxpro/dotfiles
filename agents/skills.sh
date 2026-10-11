#!/bin/bash
# Global agent skills (the ~/.agents/skills store managed by `npx skills`).
#
#   agents/skills.sh dump              regenerate agents/skills.tsv from this machine
#   agents/skills.sh dump-internal F   write the non-GitHub (company) sources to file F
#   agents/skills.sh install [TSV]     install every row of TSV (default: agents/skills.tsv)
#
# TSV columns: source <TAB> agents (space separated) <TAB> skills (space separated)
# Only public GitHub sources go into agents/skills.tsv — this repo is public.

set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOCK="$HOME/.agents/.skill-lock.json"

dump() { # $1 = public | internal
  python3 -I - "$LOCK" "$HOME/.claude/skills" "$1" <<'PY'
import collections, json, os, sys
lock, claude_dir, mode = sys.argv[1:4]
rows = collections.defaultdict(list)
for name, meta in json.load(open(lock))["skills"].items():
    public = meta.get("sourceType") == "github"
    if public != (mode == "public"):
        continue
    source = meta["source"] if public else meta.get("sourceUrl") or meta["source"]
    agents = "claude-code codex" if os.path.lexists(os.path.join(claude_dir, name)) else "codex"
    rows[(source, agents)].append(name)
for (source, agents), names in sorted(rows.items()):
    print("\t".join([source, agents, " ".join(sorted(names))]))
PY
}

install() {
  local tsv="${1:-$DIR/skills.tsv}" source agents skills
  while IFS=$'\t' read -r source agents skills; do
    [[ -z "$source" || "$source" == \#* ]] && continue
    echo "==> $source [$agents]"
    # shellcheck disable=SC2086
    npx -y skills add "$source" --global --yes --agent $agents --skill $skills </dev/null \
      || echo "!! FAILED: $source" >&2
  done <"$tsv"
}

case "${1:-}" in
  dump) dump public >"$DIR/skills.tsv"; wc -l "$DIR/skills.tsv" ;;
  dump-internal) dump internal >"${2:?output file}" ;;
  install) install "${2:-}" ;;
  *) sed -n '2,10p' "$0"; exit 1 ;;
esac
