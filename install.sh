#!/usr/bin/env bash
#
# Symlink the dotfiles in this repo into $HOME.
#
#   ./install.sh            # link everything
#   ./install.sh --dry-run  # only print what would be done
#
# Existing regular files are moved to `<file>.bak.<timestamp>` before being
# replaced, so running this on a fresh machine never silently loses config.
# Safe to re-run: links that already point at this repo are left untouched.

# Allow `sh install.sh` (as documented) on systems where sh is not bash.
if [ -z "${BASH_VERSION:-}" ]; then exec bash "$0" "$@"; fi

set -euo pipefail

# Resolve the repo root from the script location, so it works from any cwd.
DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DRY_RUN=0
[[ "${1:-}" == "-n" || "${1:-}" == "--dry-run" ]] && DRY_RUN=1

run() {
  if (( DRY_RUN )); then
    echo "[dry-run] $*"
  else
    "$@"
  fi
}

# link <path-in-repo> <target>
link() {
  local src="$DOTFILES/$1" dst="$2"

  if [[ ! -e "$src" ]]; then
    echo "skip   $dst (missing $src)"
    return
  fi

  if [[ -L "$dst" && "$(readlink "$dst")" == "$src" ]]; then
    echo "ok     $dst"
    return
  fi

  run mkdir -p "$(dirname "$dst")"

  if [[ -e "$dst" && ! -L "$dst" ]]; then
    local backup
    backup="$dst.bak.$(date +%Y%m%d%H%M%S)"
    echo "backup $dst -> $backup"
    run mv "$dst" "$backup"
  fi

  echo "link   $dst -> $src"
  run ln -sfn "$src" "$dst"
}

# bash
link bash/.bashrc ~/.bashrc

# zsh
link zsh/.zshrc    ~/.zshrc
link zsh/.zshenv   ~/.zshenv
link zsh/.zprofile ~/.zprofile
if [[ -d ~/.oh-my-zsh ]]; then
  link zsh/oh-my-zsh/themes/refined-lambda.zsh-theme \
       ~/.oh-my-zsh/custom/themes/refined-lambda.zsh-theme
else
  echo "skip   refined-lambda theme (oh-my-zsh is not installed)"
fi

# vim
link vim/.vimrc ~/.vimrc
link vim/.vimrc ~/.ideavimrc

# neovim and coc (neovim reads ~/.config/nvim, vim's coc reads ~/.vim)
link nvim/init.vim          ~/.config/nvim/init.vim
link nvim/coc-settings.json ~/.config/nvim/coc-settings.json
link nvim/coc-settings.json ~/.vim/coc-settings.json

# spacemacs
link emacs/.spacemacs ~/.spacemacs

# git
link git/.gitconfig     ~/.gitconfig
link git/.gitignore     ~/.gitignore
link git/.gitattributes ~/.gitattributes

# karabiner (macOS only)
if [[ "$(uname -s)" == "Darwin" ]]; then
  link karabiner/karabiner.json ~/.config/karabiner/karabiner.json
fi
