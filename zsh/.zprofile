# sourced on the start of a login shell.

# 10ms for key sequences
KEYTIMEOUT=1

# System binaries
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH="/usr/local/sbin:$PATH"

export PATH=$HOME/.local/bin:$PATH

# Python Pyenv verison manager
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="$PYENV_ROOT/shims:$PATH"

# Python pip
export PATH="$HOME/Library/Python/3.9/bin:$PATH"


# JS Yarn
export PATH="$HOME/.yarn/bin:$PATH"

# JS JSVU
export PATH="$HOME/.jsvu:$PATH"

# Flutter
# export PATH="$HOME/flutter/bin:$PATH"

# Sqlite
export PATH="/usr/local/opt/sqlite/bin:$PATH"

# Rust cargo

# openSSL
# export PATH="/usr/local/opt/openssl/bin:$PATH"
# export LDFLAGS="-L/usr/local/opt/openssl/lib"
# export CPPFLAGS="-I/usr/local/opt/openssl/include"
# export PKG_CONFIG_PATH="/usr/local/opt/openssl/lib/pkgconfig"

# override coq with brew-installed coq
# export PATH="/usr/local/Cellar/coq/8.9.0/bin:$PATH"

# FNL
# export PATH="$HOME/.fnl/bin:$PATH"

# LLVM
# export PATH="/usr/local/opt/llvm/bin:$PATH"
# export LDFLAGS="-L/usr/local/opt/llvm/lib"
# export CPPFLAGS="-I/usr/local/opt/llvm/include"

# Clang
# https://clang.llvm.org/docs/CommandGuide/clang.html#environment
# export CPATH=`xcrun --show-sdk-path`/usr/include


# GNU utils
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

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
