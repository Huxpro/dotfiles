# sourced on the start of a login shell.

# 10ms for key sequences
KEYTIMEOUT=1

# System binaries
export PATH=$HOME/bin:$PATH

export PATH=$HOME/.local/bin:$PATH

# Python Pyenv verison manager
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="$PYENV_ROOT/shims:$PATH"

# JS Yarn
export PATH="$HOME/.yarn/bin:$PATH"

# Rust cargo

# GNU utils
export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"

# Sqlite
export PATH="/opt/homebrew/opt/sqlite/bin:$PATH"

# https://discourse.brew.sh/t/failed-to-set-locale-category-lc-numeric-to-en-ru/5092/19
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Homebrew (hardcoded to avoid subprocess)
export HOMEBREW_PREFIX="/opt/homebrew"
export HOMEBREW_CELLAR="/opt/homebrew/Cellar"
export HOMEBREW_REPOSITORY="/opt/homebrew"
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
[ -z "${MANPATH-}" ] || export MANPATH=":${MANPATH#:}"
export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}"

# BD
[ -f "$HOME/.bytebm/config/config.sh" ] && . "$HOME/.bytebm/config/config.sh"
