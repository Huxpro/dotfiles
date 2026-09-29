#!/bin/bash

#############################################################
#                                                           #
#  CLN - Collect LiNks                                      #
#  Xuan Huang @ 2019  https://github.com/huxpro             #
#                                                           #
#                                                           #
#  Install:                                                 #
#  $ ln -s path/to/cln.sh some/where/in/your/PATH           #
#                                                           #
#  Usage:                                                   #
#  $ cln <dir_contains_links>                -- collect     #
#  $ sh <dir_contains_links>/.cln_gen.sh     -- replay      #
#                                                           #
#  Features:                                                #
#  - replace $HOME in path to `$HOME`, so the generated     #
#    script can be replayed by another user/machine         #
#  - handles dotfiles and paths with spaces                 #
#                                                           #
#############################################################

set -euo pipefail

GEN_NAME=".cln_gen.sh"

# canonical path of a link's target
# (GNU readlink, or BSD readlink on macOS >= 12.3; fall back to greadlink)
canonical() {
  readlink -f "$1" 2>/dev/null || greadlink -f "$1"
}

# shell-quote a path, keeping a leading $HOME expandable
# shellcheck disable=SC2016  # the literal "$HOME" is meant for the generated script
quote_path() {
  local path="$1"
  if [[ "$path" == "$HOME" ]]; then
    printf '"$HOME"'
  elif [[ "$path" == "$HOME"/* ]]; then
    printf '"$HOME"/%q' "${path#"$HOME"/}"
  else
    printf '%q' "$path"
  fi
}

traverse() {
  local dir="$1" gen="$2" target name source

  # include dotfiles (the common case for $HOME), and nothing if empty
  shopt -s dotglob nullglob

  for target in "$dir"/*; do
    # only looking for links
    [[ -L "$target" ]] || continue

    name="$(basename "$target")"
    source="$(canonical "$target")"
    echo "[CLN] reading link: ${target} -> ${source}"

    printf 'ln -s %s %q\n' "$(quote_path "$source")" "$name" >> "$gen"
  done
}

main() {
  local dir gen
  dir="$(cd "$1" && pwd)"
  gen="${dir}/${GEN_NAME}"

  echo "[CLN] collecting links from: ${dir}"
  echo "[CLN] intend to generate: ${gen}"

  # the replayed links are created next to the generated script
  # shellcheck disable=SC2016
  {
    echo '#!/bin/bash'
    echo 'cd "$(dirname "$0")" || exit 1'
  } > "$gen"
  local header_lines=2

  traverse "$dir" "$gen"

  if (( $(wc -l < "$gen") > header_lines )); then
    echo "[CLN] script generated: "
    cat "$gen"
  else
    rm -f "$gen"
    echo "[CLN] no links found. "
  fi
}


# args check
if [ "$#" -ne 1 ]; then
  echo "$ cln <dir_contains_links>"
  exit 1
fi

main "$1"
