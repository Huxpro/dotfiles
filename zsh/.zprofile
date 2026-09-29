# sourced on the start of a login shell.
#
# PATH entries are prepended, so the ones added *last* win: Homebrew first,
# then version managers (pyenv, yarn), then personal bin dirs on top.

# Homebrew (hardcoded instead of `eval "$(brew shellenv)"` to avoid a subprocess)
if [ -x /opt/homebrew/bin/brew ]; then
  export HOMEBREW_PREFIX="/opt/homebrew"                 # Apple Silicon
elif [ -x /usr/local/bin/brew ]; then
  export HOMEBREW_PREFIX="/usr/local"                    # Intel Mac
elif [ -x /home/linuxbrew/.linuxbrew/bin/brew ]; then
  export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"    # Linux
fi
if [ -n "$HOMEBREW_PREFIX" ]; then
  export HOMEBREW_CELLAR="$HOMEBREW_PREFIX/Cellar"
  if [ -d "$HOMEBREW_PREFIX/Homebrew" ]; then
    export HOMEBREW_REPOSITORY="$HOMEBREW_PREFIX/Homebrew"
  else
    export HOMEBREW_REPOSITORY="$HOMEBREW_PREFIX"
  fi
  export PATH="$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin:$PATH"
  [ -z "${MANPATH-}" ] || export MANPATH=":${MANPATH#:}"
  export INFOPATH="$HOMEBREW_PREFIX/share/info:${INFOPATH:-}"

  # GNU utils
  [ -d "$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin" ] && export PATH="$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin:$PATH"

  # Sqlite
  [ -d "$HOMEBREW_PREFIX/opt/sqlite/bin" ] && export PATH="$HOMEBREW_PREFIX/opt/sqlite/bin:$PATH"
fi

# Python Pyenv verison manager (must come after Homebrew so its shims win)
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="$PYENV_ROOT/shims:$PATH"

# JS Yarn
export PATH="$HOME/.yarn/bin:$PATH"

# Personal binaries
export PATH=$HOME/bin:$PATH
export PATH=$HOME/.local/bin:$PATH

# https://discourse.brew.sh/t/failed-to-set-locale-category-lc-numeric-to-en-ru/5092/19
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# BD
[ -f "$HOME/.bytebm/config/config.sh" ] && . "$HOME/.bytebm/config/config.sh"
