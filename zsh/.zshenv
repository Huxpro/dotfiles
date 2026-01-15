# always sourced

# system-wide environment settings for zsh(1)
if [ -x /usr/libexec/path_helper ]; then
    eval `/usr/libexec/path_helper -s`
fi

# make cd case-INsensitive
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
. "$HOME/.cargo/env"
