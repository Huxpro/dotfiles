# sourced on the start of a login shell.

# 10ms for key sequences
KEYTIMEOUT=1

export PATH=$HOME/bin:/usr/local/bin:$PATH

# Haskell cabal/stack/hie etc.
export PATH=$HOME/.local/bin:$PATH
export PATH="$HOME/Library/Haskell/bin:$PATH"

# Python
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="$PYENV_ROOT/shims:$PATH"

# Yarn 
export PATH="$HOME/.yarn/bin:$PATH"

export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

export PATH=/usr/local/gcc-8.1/bin:$PATH

