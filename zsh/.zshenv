# always sourced (by every zsh, including scripts) -- keep it cheap.

# system-wide environment settings for zsh(1)
if [ -x /usr/libexec/path_helper ]; then
    eval `/usr/libexec/path_helper -s`
fi

# keep PATH free of duplicates when it's prepended to by several rc files
typeset -U path PATH

# Rust cargo
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
